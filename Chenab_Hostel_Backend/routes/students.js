
const router = require('express').Router();
const db = require('../db');

// Get all students
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(
            'SELECT * FROM students ORDER BY student_id DESC'
        );
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Add student
router.post('/', async (req, res) => {
    try {
        const {
            enrolment_no, full_name, branch, email, phone,
            guardian_phone, admission_date, hostel_id, user_id
        } = req.body;

        if (!enrolment_no || !full_name || !branch) {
            return res.status(400).json({
                error: 'Enrolment number, name and branch are required'
            });
        }

        const [result] = await db.query(
            `INSERT INTO students
            (user_id, enrolment_no, full_name, branch, email, phone,
             guardian_phone, admission_date, hostel_id)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [
                user_id || null, enrolment_no, full_name, branch,
                email || null, phone || null, guardian_phone || null,
                admission_date || null, hostel_id || null
            ]
        );

        res.status(201).json({
            message: 'Student added successfully',
            student_id: result.insertId
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Update student
router.put('/:id', async (req, res) => {
    try {
        const { full_name, branch, email, phone, guardian_phone, hostel_id } = req.body;

        const [result] = await db.query(
            `UPDATE students SET full_name=?, branch=?, email=?,
             phone=?, guardian_phone=?, hostel_id=?
             WHERE student_id=?`,
            [
                full_name, branch, email || null, phone || null,
                guardian_phone || null, hostel_id || null, req.params.id
            ]
        );

        res.json({ message: 'Student updated', affectedRows: result.affectedRows });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Delete student
router.delete('/:id', async (req, res) => {
    try {
        const [result] = await db.query(
            'DELETE FROM students WHERE student_id=?',
            [req.params.id]
        );
        res.json({ message: 'Student deleted', affectedRows: result.affectedRows });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
