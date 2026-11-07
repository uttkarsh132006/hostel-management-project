
const router = require('express').Router();
const db = require('../db');

// Get all rooms
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(
            'SELECT * FROM rooms ORDER BY room_id'
        );
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Add room
router.post('/', async (req, res) => {
    try {
        const {
            hostel_id, room_number, floor_number, capacity,
            room_type, monthly_fee, room_status
        } = req.body;

        if (!hostel_id || !room_number || !capacity) {
            return res.status(400).json({
                error: 'Hostel, room number and capacity are required'
            });
        }

        const [result] = await db.query(
            `INSERT INTO rooms
            (hostel_id, room_number, floor_number, capacity,
             room_type, monthly_fee, room_status)
            VALUES (?, ?, ?, ?, ?, ?, ?)`,
            [
                hostel_id, room_number, floor_number || 0, capacity,
                room_type || 'STANDARD', monthly_fee || 3500,
                room_status || 'AVAILABLE'
            ]
        );

        res.status(201).json({
            message: 'Room added successfully',
            room_id: result.insertId
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Update room
router.put('/:id', async (req, res) => {
    try {
        const {
            room_number, floor_number, capacity,
            room_type, monthly_fee, room_status
        } = req.body;

        const [result] = await db.query(
            `UPDATE rooms SET room_number=?, floor_number=?, capacity=?,
             room_type=?, monthly_fee=?, room_status=?
             WHERE room_id=?`,
            [
                room_number, floor_number, capacity, room_type,
                monthly_fee, room_status, req.params.id
            ]
        );

        res.json({ message: 'Room updated', affectedRows: result.affectedRows });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Delete room
router.delete('/:id', async (req, res) => {
    try {
        const [result] = await db.query(
            'DELETE FROM rooms WHERE room_id=?',
            [req.params.id]
        );
        res.json({ message: 'Room deleted', affectedRows: result.affectedRows });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
