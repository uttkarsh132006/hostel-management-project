
const router = require('express').Router();
const db = require('../db');

// View fee records and balances
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM v_fee_balance');
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Add fee
router.post('/', async (req, res) => {
    try {
        const {
            student_id, academic_year, fee_type,
            amount_due, due_date
        } = req.body;

        if (!student_id || !academic_year || !fee_type ||
            amount_due === undefined || !due_date) {
            return res.status(400).json({
                error: 'Student, academic year, fee type, amount and due date are required'
            });
        }

        const [result] = await db.query(`
            INSERT INTO fee_records
            (student_id, academic_year, fee_type, amount_due, due_date)
            VALUES (?, ?, ?, ?, ?)
        `, [student_id, academic_year, fee_type, amount_due, due_date]);

        res.status(201).json({
            message: 'Fee record added',
            fee_id: result.insertId
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Update fee
router.put('/:id', async (req, res) => {
    try {
        const { amount_due, due_date, fee_status } = req.body;

        const [result] = await db.query(`
            UPDATE fee_records
            SET amount_due=?, due_date=?, fee_status=?
            WHERE fee_id=?
        `, [amount_due, due_date, fee_status, req.params.id]);

        res.json({
            message: 'Fee updated',
            affectedRows: result.affectedRows
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
