const ClientModel = require('../models/client.model');

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
            await newClient.save();
            return newClient;
        }catch(e){
            throw new Error(`Failed to register Client ${e}`);
        }
    }
}

module.exports = ClientService;