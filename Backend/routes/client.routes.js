const express = require('express');
const router = express.Router();

const{registerClient} = require('../controllers/client.controllers');

router.post('/registerClient', registerClient);

module.exports = router;