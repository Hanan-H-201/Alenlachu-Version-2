const express = require('express');
const router = express.Router();

const{registerClient, loginClient} = require('../controllers/client.controllers');

router.post('/registerClient', registerClient);
router.post('/loginClient', loginClient);

module.exports = router;