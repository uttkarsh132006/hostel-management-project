
const db = require('./db');

async function testConnection() {
    try {
        const connection = await db.getConnection();

        console.log('MySQL Connected Successfully!');

        const [rows] = await connection.query(
            'SELECT DATABASE() AS database_name'
        );

        console.log('Connected Database:', rows[0].database_name);

        connection.release();
        await db.end();

    } catch (error) {
        console.error('Database Connection Failed:', error.message);
    }
}

testConnection();
