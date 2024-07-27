const mongoose = require('mongoose');
const db = require('../config/db');

const {Schema} = mongoose;

const institutionSchema = new Schema({ 
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

    address : {
        type : String,
        required: true,
    },
    establishmentDate : {
        type : Date,
        required: true,
    },
    languageToProvideService : {
        type : String,
        required: true,
    },
    pricePerHour : {
        type : Number,
        required: true,
    }

});


const InstitutionModel = db.model('institution', institutionSchema);

module.exports = InstitutionModel;