const express = require('express');
const router = express.Router();

const {registerInstitution, loginInstitution} = require('../controllers/institution.controllers');

router.post('/registerInstitution', registerInstitution);
router.post('/loginInstitution', loginInstitution);

module.exports = router;