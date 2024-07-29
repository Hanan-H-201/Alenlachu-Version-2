const ClientModel = require('../models/client.model');
const Authentication = require('./auth.services');


class ClientService{
    static async registerClient(username, email, emergencyContact, fullName,phoneNumber, dateOfBirth, nationality, residency, isAnonymous){
        try{
            const newClient = new ClientModel({
                username,
                email,
                emergencyContact,
                fullName,
                phoneNumber,
                dateOfBirth,
                nationality,
                residency,
                isAnonymous,
            });
            return await newClient.save();
        }catch(e){
            throw new Error(`Failed to register Client ${e}`);
        }
    }

    static async loginClient(clinetUsername){
        const client = await ClientModel.findOne({clinetUsername});
        if(!client){
            return null;
        }

        const {
            _id,
            username,
            email,
            emergencyContact,
            fullName,
            phoneNumber,
            dateOfBirth,
            nationality,
            residency,
            isAnonymous,
        } = client;

        let tokenData = {
            _id: _id,
            username: username,
            email: email,
            emergencyContact: emergencyContact,
            fullName: fullName,
            phoneNumber: phoneNumber,
            dateOfBirth: dateOfBirth,
            nationality: nationality,
            residency: residency,
            isAnonymous: isAnonymous
        }

        const SECRET_KEY = process.env.SECRET_KEY


        
    }

    
}

module.exports = ClientService;