const jwt = require('jsonwebtoken');
const BlacklistModel = require('../models/blackList.model');
exports.logout = async (req, res) => {
    try {
        const token = req.headers['authorization'].split(' ')[1];
        const decoded = jwt.decode(token);
      
        const expiresAt = new Date(decoded.exp * 1000);
      
        const blacklistedToken = new BlacklistModel({ token, expiresAt });
        await blacklistedToken.save();
      
        res.status(200).send('Logged out successfully');
    } catch (err) {
        res.status(500).json({ error: `Failed to log out: ${err.message}` });
    }
}

exports.verifyToken = async (req, res) => {
    res.status(200).send('Token is valid');
}
