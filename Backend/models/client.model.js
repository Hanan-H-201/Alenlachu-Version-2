const mongoose = require('mongoose');
const db = require('../config/db');

const {Schema} = mongoose;

const clientSchema = new Schema({ 
    username :{
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    emergencyContact : {
        type : String,
        required: true
    },
    fullName : {
        type : String,
        default : null,
    },
    phoneNumber : {
        type : String,
        default : null,
    },
    dateOfBirth : {
        type : Date,
        default : null,
    },
    nationality : {
        type : String,
        default : null,
    },
    residency : {
        type : String,
        default : null,
    },
    isAnonymous : {
        type : Boolean,
        required : true,
    }
});


const ClientModel = db.model('client', clientSchema);

module.exports = ClientModel;