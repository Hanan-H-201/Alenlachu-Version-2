const mongoose = require('mongoose');
const db = require('../config/db');

const {Schema} = mongoose;

const professionalSchema = new Schema({ 
    name :{
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    phoneNumber : {
        type : String,
        default : null,
    },
    dateOfBirth : {
        type : Date,
        required: true,
    },

    nationality : {
        type : String,
        required: true,
    },

    address : {
        type : String,
        required: true,
    },
    
    profession : {
        type : String,
        required: true,
    },
    exprience :{
        type : Number,
        required: true,
    },
    
    languageToProvideService : {
        type : String,
        required: true,
    },
    pricePerHour : {
        type : Number,
        required: true,
    },

    verificationStatus : {
        type : String,
        required: true
    }

});


const ProfessionalModel = db.model('professional', professionalSchema);

module.exports = ProfessionalModel;