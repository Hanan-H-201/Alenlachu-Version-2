const express = require('express');
const router = express.Router();

const{createAwareness, getAwarenesses, getAwarnessById, updateAwareness, deleteAwareness} = require('../controllers/awareness.controllers');

router.post('/createAwareness', createAwareness);

router.get('/getAwarenesses', getAwarenesses);

router.get('/getAwarnessById', getAwarnessById);

router.put('/updateAwareness', updateAwareness);

router.delete('/deleteAwareness', deleteAwareness);

module.exports = router;