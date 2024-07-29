const InstitutionModel = require('../models/institution.model');



class InstitutionService {
    static async registerInstitution(name, email, phoneNumber, address, establishmentDate, languageToProvideService, pricePerHour){
        try{
            const newInstitution = new InstitutionModel({
                name, email, phoneNumber, address, establishmentDate, languageToProvideService, pricePerHour
            });

            return await newInstitution.save();
        }catch(e){
            throw new Error(`Failed to register Institution ${e}`);
        }
        
    }

    
}

module.exports = InstitutionService;