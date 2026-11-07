
const router = require('express').Router();
const db = require('../db');

// View payments
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT p.*, f.student_id, f.fee_type
            FROM payments p
            JOIN fee_records f ON p.fee_id = f.fee_id
            ORDER BY p.payment_id DESC
        `);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Record payment
router.post('/', async (req, res) => {
    try {
        const {
            fee_id, amount_paid, payment_date,
            payment_method, transaction_reference, received_by
        } = req.body;

        if (!fee_id || !amount_paid || !payment_date || !payment_method) {
            return res.status(400).json({
                error: 'Fee, amount, date and payment method are required'
            });
        }

        const [result] = await db.query(`
            INSERT INTO payments
            (fee_id, amount_paid, payment_date, payment_method,
             transaction_reference, received_by, payment_status)
            VALUES (?, ?, ?, ?, ?, ?, 'SUCCESS')
        `, [
            fee_id, amount_paid, payment_date, payment_method,
            transaction_reference || null, received_by || null
        ]);

        res.status(201).json({
            message: 'Payment recorded successfully',
            payment_id: result.insertId
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
