const ProfessionalModel = require('../models/profession.model');


class ProfessionService{
    static async registerProfession(name,email, phoneNumber, dateOfBirth, nationality, address, profession, exprience,  languageToProvideService, pricePerHour, verificationStatus){
        try{
            const newProfessional = new ProfessionalModel({name,email, phoneNumber, dateOfBirth, nationality, address, profession, exprience,  languageToProvideService, pricePerHour, verificationStatus});
            return await newProfessional.save();
        }catch(e){
            throw new Error(`Failed to register Profession ${e}`);
        }
    }

    
}

module.exports = ProfessionService;