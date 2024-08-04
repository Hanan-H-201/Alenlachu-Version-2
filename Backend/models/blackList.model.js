const db = require('../config/db');

const {Schema} = db;

const blacklistSchema = new Schema({
    token: String,
    createdAt: {
      type: Date,
      default: Date.now,
      expires: 86400
    },
    expiresAt: Date,
  });
  
const BlacklistModel = db.model('blacklist', blacklistSchema);

module.exports = BlacklistModel;
  