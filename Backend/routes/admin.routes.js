const express = require('express');
const router = express.Router();

const {registerAdmin, loginAdmin} = require('../controllers/admin.controllers');

router.post('/registerAdmin', registerAdmin);
router.post('/loginAdmin', loginAdmin);

module.exports = router;