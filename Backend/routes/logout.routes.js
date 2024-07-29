const express = require('express');
const router = express.Router();

const {authenticateToken} = require('../middleware/authenticateToken.middleware');
const{logout} = require('../controllers/logout.controllers');

router.post('/logout', authenticateToken, logout);

module.exports = router;