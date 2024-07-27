const express = require('express');
const router = express.Router();

const {registerInstitution} = require('../controllers/institution.controllers');

router.post('/registerInstitution', registerInstitution);

module.exports = router;