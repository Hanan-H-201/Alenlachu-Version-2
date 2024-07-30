const express = require('express');
const router = express.Router();

const {authenticateToken} = require('../middleware/authenticateToken.middleware');
const{logout, verifyToken} = require('../controllers/auth.controllers');

router.post('/logout', authenticateToken, logout);
router.post('/verify-token', authenticateToken, verifyToken);

module.exports = router;