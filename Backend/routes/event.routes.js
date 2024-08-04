const express = require('express');
const router = express.Router();

const {createEvent, getEvents, getEventById,updateEvent, deleteEvent,rsvpEvent,unRsvpEvent} = require('../controllers/event.controllers');

router.post('/createEvent', createEvent);

router.get('/getEvents', getEvents);

router.get('/getEventById', getEventById);

router.put('/updateEvent', updateEvent);

router.delete('/deleteEvent', deleteEvent);

router.post('/rsvpEvent', rsvpEvent);

router.post('/unRsvpEvent', unRsvpEvent);

module.exports = router;


