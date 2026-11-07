
const router = require('express').Router();
const db = require('../db');

// View attendance
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT a.*, s.full_name, s.enrolment_no
            FROM attendance a
            JOIN students s ON a.student_id = s.student_id
            ORDER BY a.attendance_date DESC
        `);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Mark attendance
router.post('/', async (req, res) => {
    try {
        const {
            student_id, attendance_date, check_in_time,
            check_out_time, attendance_status, marked_by, remarks
        } = req.body;

        if (!student_id || !attendance_date || !attendance_status) {
            return res.status(400).json({
                error: 'Student, date and attendance status are required'
            });
        }

        const [result] = await db.query(`
            INSERT INTO attendance
            (student_id, attendance_date, check_in_time, check_out_time,
             attendance_status, marked_by, remarks)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        `, [
            student_id, attendance_date, check_in_time || null,
            check_out_time || null, attendance_status,
            marked_by || null, remarks || null
        ]);

        res.status(201).json({
            message: 'Attendance marked successfully',
            attendance_id: result.insertId
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Update attendance
router.put('/:id', async (req, res) => {
    try {
        const {
            check_in_time, check_out_time,
            attendance_status, remarks
        } = req.body;

        const [result] = await db.query(`
            UPDATE attendance
            SET check_in_time=?, check_out_time=?,
                attendance_status=?, remarks=?
            WHERE attendance_id=?
        `, [
            check_in_time || null, check_out_time || null,
            attendance_status, remarks || null, req.params.id
        ]);

        res.json({
            message: 'Attendance updated',
            affectedRows: result.affectedRows
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
