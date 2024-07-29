const db = require('../config/db');

const {Schema} = db;

const blacklistSchema = new Schema({
    token: String,
    expiresAt: Date,
  });
  
const BlacklistModel = db.model('blacklist', blacklistSchema);

module.exports = BlacklistModel;
  