const InstitutionService = require('../services/institution.services');

exports.registerInstitution = async(req, res) => {
    try{
        const { name,
            email,
            phoneNumber,
            address,
            establishmentDate,
            languageToProvideService,
            pricePerHour} = req.body;


        const result = await InstitutionService.registerInstitution(name,
            email,
            phoneNumber,
            address,
            establishmentDate,
            languageToProvideService,
            pricePerHour);
            res.status(201).json(result);
    }catch(e){
        res.status(400).json({ error: e.message });
    }
}