const express = require('express');
const router = express.Router();

const {registerProfession} = require('../controllers/profession.controllers');

router.post('/registerProfession', registerProfession);

module.exports = router;