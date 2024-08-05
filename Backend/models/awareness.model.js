const db = require('../config/db');

const {Schema} = db;

const awarenessSchema = new Schema({
    title: {
        type: String,
        required: true,
    },
    content: {
        type: String,
        required: true,
    },
    image: {
        type: String,
        default: null,
    },
    date: {
        type: Date,
        required: true,
    },
    source: {
        type: String,
        required: true,
    },
});

const AwarenessModel = db.model('awareness', awarenessSchema);

module.exports = AwarenessModel;