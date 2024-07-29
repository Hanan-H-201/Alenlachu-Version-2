
const ClientService = require('../services/client.services');

exports.registerClient = async (req, res) => {
    try {

        const { username, email, emergencyContact, fullName, phoneNumber, dateOfBirth, nationality, residency, isAnonymous } = req.body;

        if (!username || username.trim() === '') {
            return res.status(400).json({ error: 'Username is required.' });
        }
        
        if (!email || email.trim() === '') {
            return res.status(400).json({ error: 'Email is required.' });
        }

        if (!emergencyContact || emergencyContact.trim() === '') {
            return res.status(400).json({ error: 'Emergency contact is required.' });
        }

        if (!/^\S+@\S+\.\S+$/.test(email)) {
            return res.status(400).json({ error: 'Invalid email format.' });
        }

        
        

        

        const result = await ClientService.registerClient(
            username.trim(),
            email.trim().toLowerCase(),
            emergencyContact.trim(),
            fullName ? fullName.trim() : null,
            phoneNumber ? phoneNumber.trim() : null,
            dateOfBirth ? new Date(dateOfBirth) : null,
            nationality ? nationality.trim() : null,
            residency ? residency.trim() : null,
            isAnonymous
        );

        // let tokenData = {
        //     _id: result._id,
        //     username: result.username,
        //     email: result.email,
        //     emergencyContact: result.emergencyContact,
        //     fullName: result.fullName,
        //     phoneNumber: result.phoneNumber,
        //     dateOfBirth: result.dateOfBirth,
        //     nationality: result.nationality,
        //     residency: result.residency,
        //     isAnonymous: result.isAnonymous
        // };

        // const token = await ClientService.generateToken(tokenData, "secretKey", '1hr');

        res.status(201).json(result);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

exports.loginClient = async (req,res) => {
    try {
        const {username} = req.body;
        const token = await ClientService.loginClient(username);

        if(!token){
            return res.status(401).send('Invalid credential');
        }

        res.status(200).json({status: true, token: token});
    } catch (e) {
        res.status(500).send('Internal server error');
    }
   
    const client  = ClientModel
}
