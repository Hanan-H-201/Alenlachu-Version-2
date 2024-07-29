const InstitutionService = require('../services/institution.services');

exports.registerInstitution = async (req, res) => {
    try {
        const { 
            name,
            email,
            phoneNumber,
            address,
            establishmentDate,
            languageToProvideService,
            pricePerHour
        } = req.body;

        if (!/^\S+@\S+\.\S+$/.test(email)) {
            return res.status(400).json({ error: 'Invalid email format.' });
        }

        const result = await InstitutionService.registerInstitution(
            name.trim(),
            email.trim().toLowerCase(),
            phoneNumber.trim(),
            address.trim(),
            new Date(establishmentDate),
            languageToProvideService.trim(),
            parseFloat(pricePerHour)
        );

        // let tokenData = {
        //     name: result.name,
        //     email: result.email,
        //     phoneNumber: result.phoneNumber,
        //     address: result.address,
        //     establishmentDate: result.establishmentDate,
        //     languageToProvideService: result.languageToProvideService,
        //     pricePerHour: result.pricePerHour
        // };

        // const token = await InstitutionService.generateToken(tokenData, "secretKey", '1hr');
        res.status(201).json(result);
    } catch (e) {
        res.status(400).json({ error: e.message });
    }
};
