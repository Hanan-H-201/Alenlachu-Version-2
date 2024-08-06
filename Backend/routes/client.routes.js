const express = require('express');
const router = express.Router();

const{registerClient, loginClient, addJournal, getJournals,updateJournal, deleteJournal} = require('../controllers/client.controllers');

router.post('/registerClient', registerClient);
router.post('/loginClient', loginClient);

router.post('/addJournal', addJournal);
router.get('/getJournals', getJournals);
router.put('/updateJournal', updateJournal);
router.delete('/deleteJournal', deleteJournal);

module.exports = router;