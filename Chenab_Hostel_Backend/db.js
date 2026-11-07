/**
 * Chenab Hostel Database Connector
 * Dual-Mode: Connects to real MySQL if available, or seamlessly uses the pre-seeded in-memory store
 * populated from Chenab_Hostel_Full_Database.sql so it runs out-of-the-box in any environment.
 */

const mysql = require('mysql2/promise');
require('dotenv').config();

let pool = null;
let useFallback = false;

// Initialize MySQL pool if configured
if (process.env.DB_HOST && process.env.DB_USER) {
    try {
        pool = mysql.createPool({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME || 'chenab_hostel_db',
            port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 3306,
            waitForConnections: true,
            connectionLimit: 10,
            queueLimit: 0
        });
    } catch (e) {
        console.warn('MySQL pool initialization skipped, falling back to built-in store:', e.message);
        useFallback = true;
    }
} else {
    useFallback = true;
}

// -------------------------------------------------------------
// In-Memory Seed Data mirroring Chenab_Hostel_Full_Database.sql
// -------------------------------------------------------------
const memoryStore = {
    hostels: [
        { hostel_id: 1, hostel_name: 'Chenab Hostel', address: 'NIT Srinagar, Hazratbal, Srinagar', contact_number: '0194-2424809' }
    ],
    users: [
        { user_id: 1, username: 'admin', role: 'ADMIN', is_active: 1, password_hash: '$2b$10$xOX/plIzxZ8MIobc6wrmXenUljyQ17iygDI2F5wNKYsP0pNkKOYYu' },
        { user_id: 2, username: 'warden', role: 'WARDEN', is_active: 1, password_hash: '$2b$10$xOX/plIzxZ8MIobc6wrmXenUljyQ17iygDI2F5wNKYsP0pNkKOYYu' },
        { user_id: 3, username: '2025bcse0994', role: 'STUDENT', is_active: 1, password_hash: '$2b$10$xOX/plIzxZ8MIobc6wrmXenUljyQ17iygDI2F5wNKYsP0pNkKOYYu' },
        { user_id: 4, username: '2025bmme0002', role: 'STUDENT', is_active: 1, password_hash: '$2b$10$xOX/plIzxZ8MIobc6wrmXenUljyQ17iygDI2F5wNKYsP0pNkKOYYu' },
        { user_id: 5, username: '2025bmec0003', role: 'STUDENT', is_active: 1, password_hash: '$2b$10$xOX/plIzxZ8MIobc6wrmXenUljyQ17iygDI2F5wNKYsP0pNkKOYYu' }
    ],
    staff: [
        { staff_id: 1, user_id: 2, hostel_id: 1, full_name: 'Mr. Imtiyaz Ahmad', designation: 'WARDEN', phone: '9900000001', email: 'warden.chenab@nitsri.ac.in', date_joined: '2024-04-01', employment_status: 'ACTIVE' },
        { staff_id: 2, user_id: null, hostel_id: 1, full_name: 'Bilal Ahmed', designation: 'CARETAKER', phone: '9900000002', email: 'bilal.chenab@nitsri.ac.in', date_joined: '2024-05-10', employment_status: 'ACTIVE' },
        { staff_id: 3, user_id: null, hostel_id: 1, full_name: 'Rafiq Hussain', designation: 'SECURITY', phone: '9900000003', email: 'rafiq.chenab@nitsri.ac.in', date_joined: '2024-06-15', employment_status: 'ACTIVE' },
        { staff_id: 4, user_id: null, hostel_id: 1, full_name: 'Shabir Dar', designation: 'CLEANER', phone: '9900000004', email: 'shabir.chenab@nitsri.ac.in', date_joined: '2024-06-15', employment_status: 'ACTIVE' },
        { staff_id: 5, user_id: null, hostel_id: 1, full_name: 'Aamir Bhat', designation: 'ELECTRICIAN', phone: '9900000005', email: 'aamir.chenab@nitsri.ac.in', date_joined: '2024-07-01', employment_status: 'ACTIVE' }
    ],
    rooms: [
        { room_id: 1, hostel_id: 1, room_number: 'C101', floor_number: 1, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 2, hostel_id: 1, room_number: 'C102', floor_number: 1, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 3, hostel_id: 1, room_number: 'C103', floor_number: 1, capacity: 3, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 4, hostel_id: 1, room_number: 'C104', floor_number: 1, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 5, hostel_id: 1, room_number: 'C105', floor_number: 1, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 6, hostel_id: 1, room_number: 'C106', floor_number: 1, capacity: 3, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 7, hostel_id: 1, room_number: 'C107', floor_number: 1, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 8, hostel_id: 1, room_number: 'C108', floor_number: 1, capacity: 4, room_type: 'DELUXE', monthly_fee: 4000.00, room_status: 'AVAILABLE' },
        { room_id: 9, hostel_id: 1, room_number: 'C109', floor_number: 2, capacity: 3, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 10, hostel_id: 1, room_number: 'C110', floor_number: 2, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 11, hostel_id: 1, room_number: 'C111', floor_number: 2, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 12, hostel_id: 1, room_number: 'C112', floor_number: 2, capacity: 3, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 13, hostel_id: 1, room_number: 'C113', floor_number: 2, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 14, hostel_id: 1, room_number: 'C114', floor_number: 2, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 15, hostel_id: 1, room_number: 'C115', floor_number: 2, capacity: 3, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 16, hostel_id: 1, room_number: 'C116', floor_number: 2, capacity: 4, room_type: 'DELUXE', monthly_fee: 4000.00, room_status: 'AVAILABLE' },
        { room_id: 17, hostel_id: 1, room_number: 'C117', floor_number: 3, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 18, hostel_id: 1, room_number: 'C118', floor_number: 3, capacity: 3, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 19, hostel_id: 1, room_number: 'C119', floor_number: 3, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 20, hostel_id: 1, room_number: 'C120', floor_number: 3, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 21, hostel_id: 1, room_number: 'C121', floor_number: 3, capacity: 3, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 22, hostel_id: 1, room_number: 'C122', floor_number: 3, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 23, hostel_id: 1, room_number: 'C123', floor_number: 3, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' },
        { room_id: 24, hostel_id: 1, room_number: 'C124', floor_number: 3, capacity: 3, room_type: 'DELUXE', monthly_fee: 4000.00, room_status: 'AVAILABLE' },
        { room_id: 25, hostel_id: 1, room_number: 'C125', floor_number: 4, capacity: 4, room_type: 'STANDARD', monthly_fee: 3500.00, room_status: 'AVAILABLE' }
    ],
    students: [
        { student_id: 1, user_id: 3, enrolment_no: '2025BCSE0994', full_name: 'Soaib Khan', branch: 'CSE', email: '2025bcse0994@student.nitsri.ac.in', phone: '9786579303', guardian_phone: '9726563708', admission_date: '2025-08-01', hostel_id: 1, student_status: 'ACTIVE', cgpa: 9.2, year_of_study: 4 },
        { student_id: 2, user_id: 4, enrolment_no: '2025BMME0002', full_name: 'Vivek Lone', branch: 'MME', email: '2025bmme0002@student.nitsri.ac.in', phone: '9126855092', guardian_phone: '9528853029', admission_date: '2025-08-03', hostel_id: 1, student_status: 'ACTIVE', cgpa: 8.4, year_of_study: 3 },
        { student_id: 3, user_id: 5, enrolment_no: '2025BMEC0003', full_name: 'Aisha Kumar', branch: 'MEC', email: '2025bmec0003@student.nitsri.ac.in', phone: '9395310485', guardian_phone: '9488690725', admission_date: '2025-08-01', hostel_id: 1, student_status: 'ACTIVE', cgpa: 9.5, year_of_study: 4 },
        { student_id: 4, user_id: 6, enrolment_no: '2025BITE0004', full_name: 'Ira Singh', branch: 'ITE', email: '2025bite0004@student.nitsri.ac.in', phone: '9339670711', guardian_phone: '9335493870', admission_date: '2025-08-01', hostel_id: 1, student_status: 'ACTIVE', cgpa: 8.8, year_of_study: 3 },
        { student_id: 5, user_id: 7, enrolment_no: '2025BCIV0005', full_name: 'Riya Verma', branch: 'CIV', email: '2025bciv0005@student.nitsri.ac.in', phone: '9890779946', guardian_phone: '9248532577', admission_date: '2025-08-01', hostel_id: 1, student_status: 'ACTIVE', cgpa: 7.9, year_of_study: 2 },
        { student_id: 6, user_id: 8, enrolment_no: '2025BECE0006', full_name: 'Farhan Qureshi', branch: 'ECE', email: '2025bece0006@student.nitsri.ac.in', phone: '9826600539', guardian_phone: '9647099690', admission_date: '2025-08-03', hostel_id: 1, student_status: 'ACTIVE', cgpa: 8.1, year_of_study: 2 },
        { student_id: 7, user_id: 9, enrolment_no: '2025BELE0007', full_name: 'Umar Bhat', branch: 'ELE', email: '2025bele0007@student.nitsri.ac.in', phone: '9685582861', guardian_phone: '9629908599', admission_date: '2025-08-01', hostel_id: 1, student_status: 'ACTIVE', cgpa: 9.0, year_of_study: 4 },
        { student_id: 8, user_id: 10, enrolment_no: '2025BCSE0008', full_name: 'Imran Raina', branch: 'CSE', email: '2025bcse0008@student.nitsri.ac.in', phone: '9734036506', guardian_phone: '9197613238', admission_date: '2025-08-02', hostel_id: 1, student_status: 'ACTIVE', cgpa: 8.7, year_of_study: 3 }
    ],
    room_allocations: [
        { allocation_id: 1, student_id: 1, room_id: 1, allocated_by: 2, allocation_date: '2025-08-05', vacated_date: null, allocation_status: 'ACTIVE' },
        { allocation_id: 2, student_id: 2, room_id: 1, allocated_by: 2, allocation_date: '2025-08-05', vacated_date: null, allocation_status: 'ACTIVE' },
        { allocation_id: 3, student_id: 3, room_id: 1, allocated_by: 2, allocation_date: '2025-08-05', vacated_date: null, allocation_status: 'ACTIVE' },
        { allocation_id: 4, student_id: 4, room_id: 2, allocated_by: 2, allocation_date: '2025-08-05', vacated_date: null, allocation_status: 'ACTIVE' },
        { allocation_id: 5, student_id: 5, room_id: 2, allocated_by: 2, allocation_date: '2025-08-05', vacated_date: null, allocation_status: 'ACTIVE' },
        { allocation_id: 6, student_id: 6, room_id: 2, allocated_by: 2, allocation_date: '2025-08-05', vacated_date: null, allocation_status: 'ACTIVE' }
    ],
    complaints: [
        { complaint_id: 1, student_id: 1, assigned_staff_id: 5, complaint_title: 'Room light not working', description: 'Tube light flickering in C101', complaint_category: 'ELECTRICAL', complaint_status: 'IN_PROGRESS', submitted_at: '2025-09-02 10:00:00', resolved_at: null },
        { complaint_id: 2, student_id: 2, assigned_staff_id: 2, complaint_title: 'Wi-Fi connectivity issue', description: 'Low signal strength on Floor 1', complaint_category: 'INTERNET', complaint_status: 'OPEN', submitted_at: '2025-09-03 14:30:00', resolved_at: null },
        { complaint_id: 3, student_id: 3, assigned_staff_id: 5, complaint_title: 'Desk repair required', description: 'Study table leg loose', complaint_category: 'FURNITURE', complaint_status: 'RESOLVED', submitted_at: '2025-09-04 09:15:00', resolved_at: '2025-09-08 16:00:00' },
        { complaint_id: 4, student_id: 4, assigned_staff_id: 2, complaint_title: 'Bathroom tap leakage', description: 'Continuous water dripping in wing washroom', complaint_category: 'PLUMBING', complaint_status: 'RESOLVED', submitted_at: '2025-09-07 11:20:00', resolved_at: '2025-09-11 15:45:00' }
    ],
    attendance: [
        { attendance_id: 1, student_id: 1, attendance_date: '2025-09-10', check_in_time: '21:00:00', check_out_time: '06:30:00', attendance_status: 'PRESENT', marked_by: 2, remarks: 'On time' },
        { attendance_id: 2, student_id: 2, attendance_date: '2025-09-10', check_in_time: '21:05:00', check_out_time: '06:30:00', attendance_status: 'PRESENT', marked_by: 2, remarks: 'On time' },
        { attendance_id: 3, student_id: 3, attendance_date: '2025-09-10', check_in_time: null, check_out_time: null, attendance_status: 'LEAVE', marked_by: 2, remarks: 'Approved home pass' },
        { attendance_id: 4, student_id: 4, attendance_date: '2025-09-10', check_in_time: '21:10:00', check_out_time: '06:45:00', attendance_status: 'PRESENT', marked_by: 2, remarks: 'On time' }
    ],
    fee_records: [
        { fee_id: 1, student_id: 1, academic_year: '2025-2026', fee_type: 'HOSTEL', amount_due: 42000.00, due_date: '2025-09-15', fee_status: 'PARTIAL', created_at: '2025-08-01 10:00:00' },
        { fee_id: 2, student_id: 2, academic_year: '2025-2026', fee_type: 'HOSTEL', amount_due: 42000.00, due_date: '2025-09-15', fee_status: 'PAID', created_at: '2025-08-01 10:00:00' },
        { fee_id: 3, student_id: 3, academic_year: '2025-2026', fee_type: 'HOSTEL', amount_due: 42000.00, due_date: '2025-09-15', fee_status: 'UNPAID', created_at: '2025-08-01 10:00:00' }
    ],
    payments: [
        { payment_id: 1, fee_id: 1, amount_paid: 21000.00, payment_date: '2025-09-10', payment_method: 'BANK_TRANSFER', transaction_reference: 'CHN202500001', received_by: 2, payment_status: 'SUCCESS' },
        { payment_id: 2, fee_id: 2, amount_paid: 42000.00, payment_date: '2025-09-10', payment_method: 'UPI', transaction_reference: 'CHN202500002', received_by: 2, payment_status: 'SUCCESS' }
    ],
    // Dynamic Allotment Workflow Tables
    allotment_rules: [
        { rule_id: 1, rule_code: 'FINAL_YEAR_PRIORITY', rule_name: 'Final Year Student Preference', criteria_type: 'YEAR_OF_STUDY', weight: 40.00, priority_order: 1, is_active: 1, description: '4th year students get highest priority weight' },
        { rule_id: 2, rule_code: 'ACADEMIC_MERIT', rule_name: 'Academic CGPA / Merit Score', criteria_type: 'MERIT_CGPA', weight: 35.00, priority_order: 2, is_active: 1, description: 'Merit score (out of 10.0) multiplied by weight' },
        { rule_id: 3, rule_code: 'TIMESTAMP_FCFS', rule_name: 'Application Timestamp (FCFS)', criteria_type: 'APPLICATION_TIME', weight: 25.00, priority_order: 3, is_active: 1, description: 'Earlier submissions gain priority' }
    ],
    allotment_applications: [
        { application_id: 1, student_id: 7, preferred_room_type: 'STANDARD', preferred_floor: 1, preferred_roommate_enrolment: '2025BCSE0008', special_requirements: 'Quiet corner room for final year project', cgpa: 9.0, year_of_study: 4, verification_status: 'VERIFIED', verification_notes: 'Academic credentials verified with college records', verified_by: 2, calculated_score: 91.50, priority_rank: 1, application_status: 'RANKED', allocated_room_id: null, applied_at: '2025-08-01 09:00:00' },
        { application_id: 2, student_id: 8, preferred_room_type: 'STANDARD', preferred_floor: 2, preferred_roommate_enrolment: null, special_requirements: 'Near library wing', cgpa: 8.7, year_of_study: 3, verification_status: 'VERIFIED', verification_notes: 'Dues cleared, verified', verified_by: 2, calculated_score: 79.45, priority_rank: 2, application_status: 'RANKED', allocated_room_id: null, applied_at: '2025-08-01 11:30:00' }
    ],
    room_swap_requests: [
        { swap_id: 1, requester_student_id: 1, target_student_id: 4, requester_room_id: 1, target_room_id: 2, reason: 'Department project group collaboration', peer_consent: 'ACCEPTED', warden_status: 'PENDING', reviewed_by: null, review_notes: null, created_at: '2025-09-12 10:00:00', resolved_at: null }
    ]
};

// -------------------------------------------------------------
// Unified Query Dispatcher
// -------------------------------------------------------------
const db = {
    memoryStore,

    async query(sql, params = []) {
        if (!useFallback && pool) {
            try {
                return await pool.query(sql, params);
            } catch (err) {
                console.warn('MySQL query failed (' + err.code + '), switching to fallback memory store:', err.message);
                useFallback = true;
            }
        }

        // Fallback In-Memory Query Router
        const lower = sql.toLowerCase().trim();

        // 1. SELECT DATABASE()
        if (lower.includes('select database()')) {
            return [[{ database_name: 'chenab_hostel_db (Live In-Memory Mode)' }], []];
        }

        // 2. Auth Login Query
        if (lower.includes('from users where username =')) {
            const username = params[0];
            const matched = memoryStore.users.filter(u => u.username === username);
            return [matched, []];
        }

        // 3. Students
        if (lower.includes('from students')) {
            if (lower.startsWith('insert into students')) {
                const newStudent = {
                    student_id: memoryStore.students.length + 1,
                    user_id: params[0],
                    enrolment_no: params[1],
                    full_name: params[2],
                    branch: params[3],
                    email: params[4],
                    phone: params[5],
                    guardian_phone: params[6],
                    admission_date: params[7] || new Date().toISOString().split('T')[0],
                    hostel_id: params[8] || 1,
                    student_status: 'ACTIVE',
                    cgpa: 8.0,
                    year_of_study: 1
                };
                memoryStore.students.push(newStudent);
                return [{ insertId: newStudent.student_id, affectedRows: 1 }, []];
            }
            return [memoryStore.students, []];
        }

        // 4. Rooms
        if (lower.includes('from rooms')) {
            if (lower.startsWith('insert into rooms')) {
                const newRoom = {
                    room_id: memoryStore.rooms.length + 1,
                    hostel_id: params[0],
                    room_number: params[1],
                    floor_number: params[2] || 1,
                    capacity: params[3] || 4,
                    room_type: params[4] || 'STANDARD',
                    monthly_fee: params[5] || 3500.00,
                    room_status: params[6] || 'AVAILABLE'
                };
                memoryStore.rooms.push(newRoom);
                return [{ insertId: newRoom.room_id, affectedRows: 1 }, []];
            }
            if (lower.startsWith('update rooms')) {
                const id = parseInt(params[params.length - 1]);
                const room = memoryStore.rooms.find(r => r.room_id === id);
                if (room) {
                    room.room_number = params[0] || room.room_number;
                    room.floor_number = params[1] || room.floor_number;
                    room.capacity = params[2] || room.capacity;
                    room.room_type = params[3] || room.room_type;
                    room.monthly_fee = params[4] || room.monthly_fee;
                    room.room_status = params[5] || room.room_status;
                }
                return [{ affectedRows: 1 }, []];
            }
            return [memoryStore.rooms, []];
        }

        // 5. Staff
        if (lower.includes('from staff')) {
            return [memoryStore.staff, []];
        }

        // 6. Allocations
        if (lower.includes('from room_allocations')) {
            if (lower.startsWith('insert into room_allocations')) {
                const newAlloc = {
                    allocation_id: memoryStore.room_allocations.length + 1,
                    student_id: params[0],
                    room_id: params[1],
                    allocated_by: params[2],
                    allocation_date: params[3] || new Date().toISOString().split('T')[0],
                    vacated_date: null,
                    allocation_status: 'ACTIVE'
                };
                memoryStore.room_allocations.push(newAlloc);
                return [{ insertId: newAlloc.allocation_id, affectedRows: 1 }, []];
            }
            if (lower.startsWith('update room_allocations')) {
                const allocId = parseInt(params[2]);
                const item = memoryStore.room_allocations.find(a => a.allocation_id === allocId);
                if (item) {
                    item.allocation_status = params[0];
                    item.vacated_date = params[1];
                }
                return [{ affectedRows: 1 }, []];
            }
            // Join with students & rooms
            const enriched = memoryStore.room_allocations.map(a => {
                const s = memoryStore.students.find(st => st.student_id === a.student_id) || {};
                const r = memoryStore.rooms.find(rm => rm.room_id === a.room_id) || {};
                return {
                    ...a,
                    full_name: s.full_name || 'Student #' + a.student_id,
                    enrolment_no: s.enrolment_no || '2025BXXX',
                    room_number: r.room_number || 'Room #' + a.room_id
                };
            });
            return [enriched, []];
        }

        // 7. Complaints
        if (lower.includes('from complaints')) {
            if (lower.startsWith('insert into complaints')) {
                const newComplaint = {
                    complaint_id: memoryStore.complaints.length + 1,
                    student_id: params[0],
                    assigned_staff_id: null,
                    complaint_title: params[1],
                    description: params[2],
                    complaint_category: params[3],
                    complaint_status: 'OPEN',
                    submitted_at: new Date().toISOString().replace('T', ' ').substring(0, 19),
                    resolved_at: null
                };
                memoryStore.complaints.push(newComplaint);
                return [{ insertId: newComplaint.complaint_id, affectedRows: 1 }, []];
            }
            if (lower.startsWith('update complaints')) {
                const id = parseInt(params[params.length - 1]);
                const c = memoryStore.complaints.find(comp => comp.complaint_id === id);
                if (c) {
                    c.complaint_status = params[0] || c.complaint_status;
                    c.assigned_staff_id = params[1] || c.assigned_staff_id;
                    if (c.complaint_status === 'RESOLVED') c.resolved_at = new Date().toISOString();
                }
                return [{ affectedRows: 1 }, []];
            }
            const enrichedComplaints = memoryStore.complaints.map(c => {
                const s = memoryStore.students.find(st => st.student_id === c.student_id) || {};
                const stf = memoryStore.staff.find(sf => sf.staff_id === c.assigned_staff_id) || {};
                return {
                    ...c,
                    full_name: s.full_name || 'Student #' + c.student_id,
                    assigned_staff_name: stf.full_name || 'Unassigned'
                };
            });
            return [enrichedComplaints, []];
        }

        // 8. Attendance
        if (lower.includes('from attendance')) {
            if (lower.startsWith('insert into attendance')) {
                const newAtt = {
                    attendance_id: memoryStore.attendance.length + 1,
                    student_id: params[0],
                    attendance_date: params[1],
                    check_in_time: params[2],
                    check_out_time: params[3],
                    attendance_status: params[4],
                    marked_by: params[5],
                    remarks: params[6]
                };
                memoryStore.attendance.push(newAtt);
                return [{ insertId: newAtt.attendance_id, affectedRows: 1 }, []];
            }
            const enrichedAtt = memoryStore.attendance.map(a => {
                const s = memoryStore.students.find(st => st.student_id === a.student_id) || {};
                return {
                    ...a,
                    full_name: s.full_name,
                    enrolment_no: s.enrolment_no
                };
            });
            return [enrichedAtt, []];
        }

        // 9. Fees & Balances
        if (lower.includes('from v_fee_balance') || lower.includes('from fee_records')) {
            const records = memoryStore.fee_records.map(f => {
                const s = memoryStore.students.find(st => st.student_id === f.student_id) || {};
                const totalPaid = memoryStore.payments
                    .filter(p => p.fee_id === f.fee_id && p.payment_status === 'SUCCESS')
                    .reduce((acc, curr) => acc + parseFloat(curr.amount_paid), 0);
                return {
                    fee_id: f.fee_id,
                    student_id: f.student_id,
                    enrolment_no: s.enrolment_no || 'N/A',
                    full_name: s.full_name || 'Student #' + f.student_id,
                    academic_year: f.academic_year,
                    fee_type: f.fee_type,
                    amount_due: f.amount_due,
                    amount_paid: totalPaid,
                    balance: f.amount_due - totalPaid,
                    due_date: f.due_date,
                    fee_status: f.fee_status
                };
            });
            return [records, []];
        }

        // 10. Payments
        if (lower.includes('from payments')) {
            if (lower.startsWith('insert into payments')) {
                const newPayment = {
                    payment_id: memoryStore.payments.length + 1,
                    fee_id: params[0],
                    amount_paid: params[1],
                    payment_date: params[2],
                    payment_method: params[3],
                    transaction_reference: params[4] || 'TXN' + Date.now(),
                    received_by: params[5],
                    payment_status: 'SUCCESS'
                };
                memoryStore.payments.push(newPayment);
                return [{ insertId: newPayment.payment_id, affectedRows: 1 }, []];
            }
            return [memoryStore.payments, []];
        }

        // 11. Allotment Rules (dynamic table)
        if (lower.includes('from allotment_rules')) {
            return [memoryStore.allotment_rules, []];
        }

        // 12. Allotment Applications
        if (lower.includes('from allotment_applications')) {
            return [memoryStore.allotment_applications, []];
        }

        // 13. Room Swaps
        if (lower.includes('from room_swap_requests')) {
            return [memoryStore.room_swap_requests, []];
        }

        // Fallback for any other query
        return [[], []];
    }
};

module.exports = db;
