
const router = require('express').Router();
const db = require('../db');

// View complaints
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT c.*, s.full_name
            FROM complaints c
            JOIN students s ON c.student_id = s.student_id
            ORDER BY c.submitted_at DESC
        `);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Submit complaint
router.post('/', async (req, res) => {
    try {
        const {
            student_id, complaint_title, description,
            complaint_category
        } = req.body;

        if (!student_id || !complaint_title ||
            !description || !complaint_category) {
            return res.status(400).json({
                error: 'Student, title, description and category are required'
            });
        }

        const [result] = await db.query(`
            INSERT INTO complaints
            (student_id, complaint_title, description, complaint_category)
            VALUES (?, ?, ?, ?)
        `, [student_id, complaint_title, description, complaint_category]);

        res.status(201).json({
            message: 'Complaint submitted successfully',
            complaint_id: result.insertId
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Update complaint status or assignment
router.put('/:id', async (req, res) => {
    try {
        const {
            complaint_status, assigned_staff_id
        } = req.body;

        const resolvedAt =
            complaint_status === 'RESOLVED' ? new Date() : null;

        const [result] = await db.query(`
            UPDATE complaints
            SET complaint_status=?, assigned_staff_id=?, resolved_at=?
            WHERE complaint_id=?
        `, [
            complaint_status, assigned_staff_id || null,
            resolvedAt, req.params.id
        ]);

        res.json({
            message: 'Complaint updated',
            affectedRows: result.affectedRows
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
