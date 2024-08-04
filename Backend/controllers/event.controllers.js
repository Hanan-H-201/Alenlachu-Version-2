const EventService = require('../services/event.services');

exports.createEvent = async (req, res) => {
    try{
        const{title, description, date, time, image, organizer, location, rsvps} = req.body;
        const result = await EventService.createEvent(title, description, date, time, image, organizer, location, rsvps);

        res.status(201).json(result);
    }catch(e){
        res.status(400).json({ error: e.message });
    }
};


exports.getEvents = async (req, res) => {
  try{
    const events = await EventService.getEvents();
    res.status(200).json(events);
  }catch(e){
    res.status(400).json({ error: e.message });
  }
};

// Get Event by ID
exports.getEventById = async (req, res) => {
 try{
    const {id}= req.body;
    const event = await EventService.getEventById(id);
    if(!event){
        res.status(404).json({ error: 'Event not found' });
    }else{
        res.status(200).json(event);
    }

    return 

 }catch(e){
    res.status(400).json({ error: e.message });
 
 }
};

// Update Event by ID
exports.updateEvent = async (req, res) => {
    try{
        const{id, updatedFields} = req.body;
        const result = await EventService.updateEvent(id, updatedFields);
        if(!result){
            res.status(404).json({ error: 'Event not found' });
        }else{
            res.status(200).json(result);
        }
    }catch(e){
        res.status(400).json({ error: e.message });
    }
};

// Delete Event by ID
exports.deleteEvent = async (req, res) => {
  try{
    const {id} = req.body;
    const result = await EventService.deleteEvent(id);
    if(!result){
      res.status(404).json({ error: 'Event not found' });
    }else{
      res.status(200).json(result);
    }

  }catch(e){
    res.status(400).json({ error: e.message });
  }
};

exports.rsvpEvent = async (req, res) => {
  try {
    const{eventId, userId} = req.body;

    const result = await EventService.rsvpEvent(eventId, userId);

    if(!result) {
        return res.status(400).json({ error: 'Unable to RSVP' });
    }else{
        res.status(200).json(result);
    }
    
  } catch (err) {
    console.error(err);
    res.status(400).json({ error: err.message });
  }
};

exports.unRsvpEvent = async (req, res) => {
    try {
        const{eventId, userId} = req.body;
    
        const result = await EventService.unrsvpEvent(eventId, userId);
    
        if(!result) {
            return res.status(400).json({ error: 'Unable to UnRSVP' });
        }else{
            res.status(200).json(result);
        }
        
      } catch (err) {
        console.error(err);
        res.status(400).json({ error: err.message });
      }
};
