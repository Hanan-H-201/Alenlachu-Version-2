const ProfessionService = require('../services/profession.services');

exports.registerProfession = async (req, res) => {
    try {
       
        const {
            name,
            email,
            phoneNumber,
            dateOfBirth,
            nationality,
            address,
            profession,
            experience,
            languageToProvideService,
            pricePerHour,
            verificationStatus
        } = req.body;

        if (!/^\S+@\S+\.\S+$/.test(email)) {
            return res.status(400).json({ error: 'Invalid email format.' });
        }

        const result = await ProfessionService.registerProfession(
            name.trim(),
            email.trim().toLowerCase(),
            phoneNumber ? phoneNumber.trim() : null,
            new Date(dateOfBirth),
            nationality.trim(),
            address.trim(),
            profession.trim(),
           Number(experience),
            languageToProvideService.trim(),
            parseFloat(pricePerHour),
            verificationStatus.trim()
        );

        // let tokenData = {
        //     name: result.name,
        //     email: result.email,
        //     phoneNumber: result.phoneNumber,
        //     dateOfBirth: result.dateOfBirth,
        //     nationality: result.nationality,
        //     address: result.address,
        //     profession: result.profession,
        //     experience: result.experience,
        //     languageToProvideService: result.languageToProvideService,
        //     pricePerHour: result.pricePerHour,
        //     verificationStatus: result.verificationStatus
        // };

        // const token = await ProfessionService.generateToken(tokenData, "secretKey", '1hr');
        res.status(201).json(result);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};
