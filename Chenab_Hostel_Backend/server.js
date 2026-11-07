const express = require('express');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

const app = express();
const db = require('./db');

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// API Routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/students', require('./routes/students'));
app.use('/api/rooms', require('./routes/rooms'));
app.use('/api/staff', require('./routes/staff'));
app.use('/api/allocations', require('./routes/allocations'));
app.use('/api/fees', require('./routes/fees'));
app.use('/api/payments', require('./routes/payments'));
app.use('/api/complaints', require('./routes/complaints'));
app.use('/api/attendance', require('./routes/attendance'));
app.use('/api/allotments', require('./routes/allotments'));

// Test & Health
app.get('/api/health', (req, res) => {
    res.json({
        status: 'UP',
        service: 'Chenab Hostel Management API',
        timestamp: new Date().toISOString()
    });
});

app.get('/api/test-db', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT DATABASE() AS database_name');
        res.json({
            success: true,
            message: 'Database Connected Successfully',
            database: rows && rows[0] ? rows[0].database_name : 'chenab_hostel_db'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message
        });
    }
});

// Serve frontend fallback for SPA routes
app.use((req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

const PORT = process.env.PORT || 5001;

const server = app.listen(PORT, () => {
    console.log(`===================================================`);
    console.log(` Chenab Hostel Management System is Live!`);
    console.log(` Web Frontend: http://localhost:${PORT}`);
    console.log(` API Endpoint: http://localhost:${PORT}/api/health`);
    console.log(`===================================================`);
});

module.exports = app;
