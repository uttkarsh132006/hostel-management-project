
const router = require('express').Router();
const db = require('../db');

// Get all staff
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(
            'SELECT * FROM staff ORDER BY staff_id'
        );
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Add staff
router.post('/', async (req, res) => {
    try {
        const {
            user_id, hostel_id, full_name, designation,
            phone, email, date_joined
        } = req.body;

        if (!hostel_id || !full_name || !designation) {
            return res.status(400).json({
                error: 'Hostel, name and designation are required'
            });
        }

        const [result] = await db.query(
            `INSERT INTO staff
            (user_id, hostel_id, full_name, designation, phone, email, date_joined)
            VALUES (?, ?, ?, ?, ?, ?, ?)`,
            [
                user_id || null, hostel_id, full_name, designation,
                phone || null, email || null, date_joined || null
            ]
        );

        res.status(201).json({
            message: 'Staff added successfully',
            staff_id: result.insertId
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Update staff
router.put('/:id', async (req, res) => {
    try {
        const { full_name, designation, phone, email, employment_status } = req.body;

        const [result] = await db.query(
            `UPDATE staff SET full_name=?, designation=?, phone=?,
             email=?, employment_status=? WHERE staff_id=?`,
            [
                full_name, designation, phone || null, email || null,
                employment_status || 'ACTIVE', req.params.id
            ]
        );

        res.json({ message: 'Staff updated', affectedRows: result.affectedRows });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Delete staff
router.delete('/:id', async (req, res) => {
    try {
        const [result] = await db.query(
            'DELETE FROM staff WHERE staff_id=?',
            [req.params.id]
        );
        res.json({ message: 'Staff deleted', affectedRows: result.affectedRows });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
