const ClientService = require('../services/client.services');

exports.registerClient = async (req, res) => {
    try{
        const {username,email,emergencyContact,fullName,phoneNumber, dateOfBirth,nationality,residency, isAnonymous} = req.body;
        const result = await ClientService.registerClient(username,
            email,
            emergencyContact,
            fullName,
            phoneNumber,
            dateOfBirth,
            nationality,
            residency,
            isAnonymous,);

        res.status(201).json(result);
    }catch(err){
        res.status(400).json({ error: err.message });
    }
}