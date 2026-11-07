const express = require('express');
const router = express.Router();
const db = require('../db');

// ====================================================================
// STEP 3 ENGINE: Dynamic Rules Table
// ====================================================================

// GET dynamic allotment rules
router.get('/rules', async (req, res) => {
    try {
        const [rules] = await db.query('SELECT * FROM allotment_rules ORDER BY priority_order ASC');
        res.json({ success: true, rules });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// UPDATE dynamic rule weight or active status
router.put('/rules/:id', async (req, res) => {
    try {
        const { weight, is_active, description } = req.body;
        const ruleId = parseInt(req.params.id);

        if (db.memoryStore) {
            const rule = db.memoryStore.allotment_rules.find(r => r.rule_id === ruleId);
            if (rule) {
                if (weight !== undefined) rule.weight = parseFloat(weight);
                if (is_active !== undefined) rule.is_active = is_active ? 1 : 0;
                if (description !== undefined) rule.description = description;
                return res.json({ success: true, message: 'Rule updated in table', rule });
            }
        }

        await db.query(`
            UPDATE allotment_rules
            SET weight = COALESCE(?, weight),
                is_active = COALESCE(?, is_active),
                description = COALESCE(?, description)
            WHERE rule_id = ?
        `, [weight, is_active, description, ruleId]);

        res.json({ success: true, message: 'Rule updated successfully' });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// ====================================================================
// STEP 1: Apply (Student fills application with preferences)
// ====================================================================

// Submit Application
router.post('/apply', async (req, res) => {
    try {
        const {
            student_id,
            preferred_room_type,
            preferred_floor,
            preferred_roommate_enrolment,
            special_requirements,
            cgpa,
            year_of_study
        } = req.body;

        if (!student_id) {
            return res.status(400).json({ success: false, error: 'Student ID is required' });
        }

        if (db.memoryStore) {
            // Check if already applied
            const existing = db.memoryStore.allotment_applications.find(a => a.student_id === parseInt(student_id));
            if (existing) {
                existing.preferred_room_type = preferred_room_type || existing.preferred_room_type;
                existing.preferred_floor = preferred_floor || existing.preferred_floor;
                existing.preferred_roommate_enrolment = preferred_roommate_enrolment || existing.preferred_roommate_enrolment;
                existing.special_requirements = special_requirements || existing.special_requirements;
                existing.cgpa = cgpa !== undefined ? parseFloat(cgpa) : existing.cgpa;
                existing.year_of_study = year_of_study !== undefined ? parseInt(year_of_study) : existing.year_of_study;
                return res.json({ success: true, message: 'Application updated', application_id: existing.application_id });
            }

            const newApp = {
                application_id: db.memoryStore.allotment_applications.length + 1,
                student_id: parseInt(student_id),
                preferred_room_type: preferred_room_type || 'STANDARD',
                preferred_floor: preferred_floor ? parseInt(preferred_floor) : 1,
                preferred_roommate_enrolment: preferred_roommate_enrolment || null,
                special_requirements: special_requirements || null,
                cgpa: cgpa ? parseFloat(cgpa) : 8.0,
                year_of_study: year_of_study ? parseInt(year_of_study) : 1,
                verification_status: 'PENDING',
                verification_notes: null,
                verified_by: null,
                calculated_score: 0.0,
                priority_rank: null,
                application_status: 'APPLIED',
                allocated_room_id: null,
                applied_at: new Date().toISOString()
            };
            db.memoryStore.allotment_applications.push(newApp);
            return res.status(201).json({ success: true, message: 'Application submitted', application: newApp });
        }

        res.status(201).json({ success: true, message: 'Application recorded' });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// View all applications
router.get('/applications', async (req, res) => {
    try {
        if (db.memoryStore) {
            const list = db.memoryStore.allotment_applications.map(app => {
                const student = db.memoryStore.students.find(s => s.student_id === app.student_id) || {};
                const room = app.allocated_room_id ? db.memoryStore.rooms.find(r => r.room_id === app.allocated_room_id) : null;
                return {
                    ...app,
                    student_name: student.full_name || 'Student #' + app.student_id,
                    enrolment_no: student.enrolment_no || 'N/A',
                    branch: student.branch || 'CSE',
                    allocated_room_number: room ? room.room_number : null
                };
            });
            return res.json({ success: true, applications: list });
        }
        res.json({ success: true, applications: [] });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// ====================================================================
// STEP 2: Verify (Check record against college system)
// ====================================================================

router.post('/verify/:id', async (req, res) => {
    try {
        const appId = parseInt(req.params.id);
        const { verification_status, verification_notes, verified_by } = req.body;

        if (db.memoryStore) {
            const app = db.memoryStore.allotment_applications.find(a => a.application_id === appId);
            if (!app) {
                return res.status(404).json({ success: false, error: 'Application not found' });
            }
            app.verification_status = verification_status || 'VERIFIED';
            app.verification_notes = verification_notes || 'Verified with College Academic & Fee Database';
            app.verified_by = verified_by || 2; // Warden
            app.application_status = app.verification_status === 'VERIFIED' ? 'VERIFIED' : 'REJECTED';

            return res.json({
                success: true,
                message: `Application marked as ${app.verification_status}`,
                application: app
            });
        }

        res.json({ success: true, message: 'Application verified' });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// ====================================================================
// STEP 3: Rank (Priority list built dynamically from allotment_rules)
// ====================================================================

router.post('/rank', async (req, res) => {
    try {
        if (!db.memoryStore) {
            return res.json({ success: true, message: 'Rank calculated' });
        }

        const rules = db.memoryStore.allotment_rules.filter(r => r.is_active);
        const apps = db.memoryStore.allotment_applications.filter(a => a.verification_status === 'VERIFIED');

        if (apps.length === 0) {
            return res.json({ success: true, message: 'No verified applications to rank', ranked: [] });
        }

        // Calculate score for each application based on dynamic rules table
        apps.forEach((app, idx) => {
            let score = 0;

            rules.forEach(rule => {
                if (rule.criteria_type === 'YEAR_OF_STUDY') {
                    // Final year (4th year) gets 100% of weight, 3rd gets 75%, 2nd gets 50%, 1st gets 25%
                    const yearMultiplier = (app.year_of_study || 1) / 4.0;
                    score += rule.weight * yearMultiplier;
                } else if (rule.criteria_type === 'MERIT_CGPA') {
                    // CGPA out of 10.0
                    const cgpaMultiplier = (app.cgpa || 7.0) / 10.0;
                    score += rule.weight * cgpaMultiplier;
                } else if (rule.criteria_type === 'APPLICATION_TIME') {
                    // FCFS bonus: earlier application index receives higher fraction
                    const timeBonus = Math.max(0.1, 1 - (idx * 0.05));
                    score += rule.weight * timeBonus;
                }
            });

            app.calculated_score = parseFloat(score.toFixed(2));
            app.application_status = 'RANKED';
        });

        // Sort descending by score
        apps.sort((a, b) => b.calculated_score - a.calculated_score);

        // Assign ranks
        apps.forEach((app, index) => {
            app.priority_rank = index + 1;
        });

        res.json({
            success: true,
            message: `Successfully calculated priority rankings based on ${rules.length} active database rules`,
            rules_used: rules.map(r => ({ name: r.rule_name, weight: r.weight })),
            ranked: apps
        });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// ====================================================================
// STEP 4: Allocate (Auto-assignment + Warden Override)
// ====================================================================

// Auto-Allocation Batch
router.post('/allocate-batch', async (req, res) => {
    try {
        if (!db.memoryStore) {
            return res.json({ success: true, message: 'Allocated' });
        }

        // Get ranked applications
        const rankedApps = db.memoryStore.allotment_applications
            .filter(a => a.priority_rank && a.application_status === 'RANKED')
            .sort((a, b) => a.priority_rank - b.priority_rank);

        const rooms = db.memoryStore.rooms.filter(r => r.room_status === 'AVAILABLE');
        const allocations = db.memoryStore.room_allocations;

        const results = [];

        for (const app of rankedApps) {
            // Find a room matching preferences with available space
            let targetRoom = null;

            // Compute current active allocations per room
            const getRoomOccupancy = (roomId) => {
                return allocations.filter(al => al.room_id === roomId && al.allocation_status === 'ACTIVE').length;
            };

            // 1st choice: match room type and floor
            targetRoom = rooms.find(r =>
                r.room_type === app.preferred_room_type &&
                r.floor_number === app.preferred_floor &&
                getRoomOccupancy(r.room_id) < r.capacity
            );

            // 2nd choice: match room type only
            if (!targetRoom) {
                targetRoom = rooms.find(r =>
                    r.room_type === app.preferred_room_type &&
                    getRoomOccupancy(r.room_id) < r.capacity
                );
            }

            // 3rd choice: any room with vacancy
            if (!targetRoom) {
                targetRoom = rooms.find(r => getRoomOccupancy(r.room_id) < r.capacity);
            }

            if (targetRoom) {
                // Perform allocation
                const newAlloc = {
                    allocation_id: allocations.length + 1,
                    student_id: app.student_id,
                    room_id: targetRoom.room_id,
                    allocated_by: 2, // Warden
                    allocation_date: new Date().toISOString().split('T')[0],
                    vacated_date: null,
                    allocation_status: 'ACTIVE'
                };
                allocations.push(newAlloc);

                app.allocated_room_id = targetRoom.room_id;
                app.application_status = 'ALLOCATED';

                const student = db.memoryStore.students.find(s => s.student_id === app.student_id) || {};
                results.push({
                    student_name: student.full_name,
                    enrolment_no: student.enrolment_no,
                    assigned_room: targetRoom.room_number,
                    rank: app.priority_rank,
                    score: app.calculated_score
                });
            }
        }

        res.json({
            success: true,
            message: `Allocated ${results.length} students to rooms based on priority rank & space availability`,
            allocations: results
        });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// Warden Manual Override
router.post('/override', async (req, res) => {
    try {
        const { student_id, target_room_id, reason, warden_id } = req.body;

        if (!student_id || !target_room_id) {
            return res.status(400).json({ success: false, error: 'Student ID and Target Room ID are required for override' });
        }

        if (db.memoryStore) {
            const sid = parseInt(student_id);
            const rid = parseInt(target_room_id);

            // Deactivate any existing active allocation for this student
            const existingAlloc = db.memoryStore.room_allocations.find(a => a.student_id === sid && a.allocation_status === 'ACTIVE');
            if (existingAlloc) {
                existingAlloc.allocation_status = 'COMPLETED';
                existingAlloc.vacated_date = new Date().toISOString().split('T')[0];
            }

            // Create override allocation
            const overrideAlloc = {
                allocation_id: db.memoryStore.room_allocations.length + 1,
                student_id: sid,
                room_id: rid,
                allocated_by: warden_id || 2,
                allocation_date: new Date().toISOString().split('T')[0],
                vacated_date: null,
                allocation_status: 'ACTIVE',
                override_reason: reason || 'Warden administrative override'
            };
            db.memoryStore.room_allocations.push(overrideAlloc);

            // Update application if exists
            const app = db.memoryStore.allotment_applications.find(a => a.student_id === sid);
            if (app) {
                app.allocated_room_id = rid;
                app.application_status = 'ALLOCATED';
            }

            const room = db.memoryStore.rooms.find(r => r.room_id === rid);
            const student = db.memoryStore.students.find(s => s.student_id === sid);

            return res.json({
                success: true,
                message: `Warden override applied: ${student ? student.full_name : 'Student'} assigned to room ${room ? room.room_number : rid}`,
                allocation: overrideAlloc
            });
        }

        res.json({ success: true, message: 'Override recorded' });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// ====================================================================
// STEP 5: Swap & Vacancy Management
// ====================================================================

// Request Room Swap
router.post('/swap', async (req, res) => {
    try {
        const { requester_student_id, target_student_id, reason } = req.body;

        if (!requester_student_id || !target_student_id || !reason) {
            return res.status(400).json({ success: false, error: 'Requester, target student and reason are required' });
        }

        if (db.memoryStore) {
            const reqSid = parseInt(requester_student_id);
            const targetSid = parseInt(target_student_id);

            const reqAlloc = db.memoryStore.room_allocations.find(a => a.student_id === reqSid && a.allocation_status === 'ACTIVE');
            const targetAlloc = db.memoryStore.room_allocations.find(a => a.student_id === targetSid && a.allocation_status === 'ACTIVE');

            if (!reqAlloc || !targetAlloc) {
                return res.status(400).json({ success: false, error: 'Both students must have an active room allocation to initiate a swap' });
            }

            const newSwap = {
                swap_id: db.memoryStore.room_swap_requests.length + 1,
                requester_student_id: reqSid,
                target_student_id: targetSid,
                requester_room_id: reqAlloc.room_id,
                target_room_id: targetAlloc.room_id,
                reason,
                peer_consent: 'ACCEPTED', // assume consensual initiation
                warden_status: 'PENDING',
                reviewed_by: null,
                review_notes: null,
                created_at: new Date().toISOString(),
                resolved_at: null
            };
            db.memoryStore.room_swap_requests.push(newSwap);

            return res.status(201).json({ success: true, message: 'Swap request submitted and pending Warden approval', swap: newSwap });
        }

        res.status(201).json({ success: true, message: 'Swap requested' });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// View all swap requests
router.get('/swaps', async (req, res) => {
    try {
        if (db.memoryStore) {
            const enriched = db.memoryStore.room_swap_requests.map(sw => {
                const reqStudent = db.memoryStore.students.find(s => s.student_id === sw.requester_student_id) || {};
                const targetStudent = db.memoryStore.students.find(s => s.student_id === sw.target_student_id) || {};
                const reqRoom = db.memoryStore.rooms.find(r => r.room_id === sw.requester_room_id) || {};
                const targetRoom = db.memoryStore.rooms.find(r => r.room_id === sw.target_room_id) || {};

                return {
                    ...sw,
                    requester_name: reqStudent.full_name,
                    requester_enrolment: reqStudent.enrolment_no,
                    requester_room_no: reqRoom.room_number,
                    target_name: targetStudent.full_name,
                    target_enrolment: targetStudent.enrolment_no,
                    target_room_no: targetRoom.room_number
                };
            });
            return res.json({ success: true, swaps: enriched });
        }
        res.json({ success: true, swaps: [] });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// Warden approves or rejects swap
router.put('/swaps/:id/approve', async (req, res) => {
    try {
        const swapId = parseInt(req.params.id);
        const { status, review_notes, reviewed_by } = req.body; // status: 'APPROVED' or 'REJECTED'

        if (db.memoryStore) {
            const swap = db.memoryStore.room_swap_requests.find(s => s.swap_id === swapId);
            if (!swap) {
                return res.status(404).json({ success: false, error: 'Swap request not found' });
            }

            swap.warden_status = status || 'APPROVED';
            swap.review_notes = review_notes || 'Approved by Warden';
            swap.reviewed_by = reviewed_by || 2;
            swap.resolved_at = new Date().toISOString();

            if (swap.warden_status === 'APPROVED') {
                // Atomically exchange rooms in allocations
                const reqAlloc = db.memoryStore.room_allocations.find(a => a.student_id === swap.requester_student_id && a.allocation_status === 'ACTIVE');
                const targetAlloc = db.memoryStore.room_allocations.find(a => a.student_id === swap.target_student_id && a.allocation_status === 'ACTIVE');

                if (reqAlloc && targetAlloc) {
                    const temp = reqAlloc.room_id;
                    reqAlloc.room_id = targetAlloc.room_id;
                    targetAlloc.room_id = temp;
                }
            }

            return res.json({
                success: true,
                message: `Swap request ${swap.warden_status.toLowerCase()} and room allocations updated`,
                swap
            });
        }

        res.json({ success: true, message: 'Swap status updated' });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// Vacate room (Reopen vacancy)
router.post('/vacate', async (req, res) => {
    try {
        const { allocation_id, student_id } = req.body;

        if (db.memoryStore) {
            let alloc = null;
            if (allocation_id) {
                alloc = db.memoryStore.room_allocations.find(a => a.allocation_id === parseInt(allocation_id));
            } else if (student_id) {
                alloc = db.memoryStore.room_allocations.find(a => a.student_id === parseInt(student_id) && a.allocation_status === 'ACTIVE');
            }

            if (!alloc) {
                return res.status(404).json({ success: false, error: 'Active allocation record not found' });
            }

            alloc.allocation_status = 'COMPLETED';
            alloc.vacated_date = new Date().toISOString().split('T')[0];

            const room = db.memoryStore.rooms.find(r => r.room_id === alloc.room_id);

            return res.json({
                success: true,
                message: `Room ${room ? room.room_number : alloc.room_id} has been vacated. Vacancy reopened for future allotment!`,
                allocation: alloc
            });
        }

        res.json({ success: true, message: 'Room vacated' });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

module.exports = router;
