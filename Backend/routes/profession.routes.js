const express = require('express');
const router = express.Router();

const {registerProfession, loginProfessional} = require('../controllers/profession.controllers');

router.post('/registerProfession', registerProfession);
router.post('/loginProfessional', loginProfessional);

module.exports = router;