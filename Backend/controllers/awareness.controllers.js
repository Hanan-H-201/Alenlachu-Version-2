const AwarenessService = require('../services/awareness.services');


exports.createAwareness = async (req, res) => {
    try{
        const{title, content, image, date, source} = req.body;
        const result = await AwarenessService.createAwareness(title, content, image, date, source);

        res.status(201).json(result);
    }catch(err){
        res.status(400).json({ error: err.message });
    }
}


exports.getAwarenesses = async (req, res) => {
    try{
        const result = await AwarenessService.getAllAwarenesses();
        res.status(200).json(result);
    }catch(err){
        res.status(400).json({ error: err.message });
    }
}

exports.getAwarnessById = async (req, res) => {
    try{
        const {id} = req.query;
        const result = await AwarenessService.getAwarenessById(id);
        if(!result){
            res.status(404).json({ error: 'Awareness not found' });
        }else{
            res.status(200).json(result);
        }


    }catch(err){
        res.status(400).json({ error: err.message });
    }
}

exports.updateAwareness = async (req, res) => {
    try{
        const {id} = req.query;
        const {updatedFields} = req.body;

        const result = await AwarenessService.updateAwareness(id, updatedFields);
        if(!result){
            res.status(404).json({ error: 'Awareness not found' });
        }else{
            res.status(200).json(result);
        }
    }catch(err){
        res.status(400).json({ error: err.message });
    }
}


exports.deleteAwareness = async (req, res) => {
    try{
        const {id} = req.query;
        const result = await AwarenessService.deleteAwareness(id);
        if(!result){
            res.status(404).json({ error: 'Awareness not found' });
        }else{
            res.status(200).json(result);
        }
    }catch(err){
        res.status(400).json({ error: err.message });
    }
}