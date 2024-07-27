const ProfessionalModel = require('../models/profession.model');

class ProfessionService{
    static async registerProfession(name,email, phoneNumber, dateOfBirth, nationality, address, profession, exprience,  languageToProvideService, pricePerHour, verificationStatus){
        try{
            const newProfessional = new ProfessionalModel({name,email, phoneNumber, dateOfBirth, nationality, address, profession, exprience,  languageToProvideService, pricePerHour, verificationStatus});
            await newProfessional.save();
            return newProfessional;
        }catch(e){
            throw new Error(`Failed to register Profession ${e}`);
        }
    }
}

module.exports = ProfessionService;