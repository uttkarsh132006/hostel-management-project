
const router = require('express').Router();
const db = require('../db');

// View allocations
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT a.*, s.full_name, s.enrolment_no, r.room_number
            FROM room_allocations a
            JOIN students s ON a.student_id = s.student_id
            JOIN rooms r ON a.room_id = r.room_id
            ORDER BY a.allocation_id DESC
        `);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Allocate room
router.post('/', async (req, res) => {
    try {
        const { student_id, room_id, allocated_by, allocation_date } = req.body;

        if (!student_id || !room_id || !allocation_date) {
            return res.status(400).json({
                error: 'Student, room and allocation date are required'
            });
        }

        const [result] = await db.query(`
            INSERT INTO room_allocations
            (student_id, room_id, allocated_by, allocation_date, allocation_status)
            VALUES (?, ?, ?, ?, 'ACTIVE')
        `, [student_id, room_id, allocated_by || null, allocation_date]);

        res.status(201).json({
            message: 'Room allocated successfully',
            allocation_id: result.insertId
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Vacate or change allocation status
router.put('/:id', async (req, res) => {
    try {
        const { allocation_status, vacated_date } = req.body;

        const [result] = await db.query(`
            UPDATE room_allocations
            SET allocation_status = ?, vacated_date = ?
            WHERE allocation_id = ?
        `, [
            allocation_status,
            vacated_date || null,
            req.params.id
        ]);

        res.json({
            message: 'Allocation updated',
            affectedRows: result.affectedRows
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
