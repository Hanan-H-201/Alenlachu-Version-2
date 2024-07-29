
const db = require('../config/db');

const {Schema} = mongoose;

const institutionSchema = new Schema({
    name: {
        type: String,
        unique: true,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
        match: [/^\S+@\S+\.\S+$/, 'Please use a valid email address.']
    },
    phoneNumber: {
        type: String,
        required: true,
    },
    address: {
        type: String,
        required: true,
    },
    establishmentDate: {
        type: Date,
        required: true,
    },
    languageToProvideService: {
        type: String,
        required: true,
    },
    pricePerHour: {
        type: Number,
        required: true,
    }
});



const InstitutionModel = db.model('institution', institutionSchema);

module.exports = InstitutionModel;