const ProfessionService = require('../services/profession.services');

exports.registerProfession = async (req, res) => {
    try{
        const {name,
            email,
            phoneNumber,
            dateOfBirth,
            nationality,
            address,
            profession,
            exprience,
            languageToProvideService,
            pricePerHour,
            verificationStatus} = req.body;
            const result = await ProfessionService.registerProfession(name,
                email,
                phoneNumber,
                dateOfBirth,
                nationality,
                address,
                profession,
                exprience,
                languageToProvideService,
                pricePerHour,
                verificationStatus);

                res.status(201).json(result);
    }catch(err){
        res.status(400).json({ error: err.message });
    }
}