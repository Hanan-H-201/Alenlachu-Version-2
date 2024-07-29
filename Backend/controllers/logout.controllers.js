const redis = require('redis');
const client = redis.createClient();

// client.connect().catch(console.error);

// client.on('connect', () => {
//     console.log('Connected to Redis');
// });

// client.on('error', (err) => {
//     console.error('Redis error:', err);
// });

exports.logout = async (req, res) => {
    try {
        const authHeader = req.header('Authorization');
        if (!authHeader) {
            return res.status(400).json({ error: 'Authorization header missing' });
        }

        const token = authHeader.replace('Bearer ', '');
        await client.set(token, 'invalid', 'EX', 3600); // Token expires in 1 hour
        res.status(200).json({ message: 'Logged out successfully' });
    } catch (err) {
        res.status(500).json({ error: `Failed to log out: ${err.message}` });
    }
}
