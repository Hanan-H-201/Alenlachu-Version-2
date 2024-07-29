const BlacklistModel = require("../models/blackList.model");
const jwt = require('jsonwebtoken');

exports.authenticateToken = async (req, res, next) => {
  try{
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
  
    if (!token) return res.status(401).send('Access denied');
  
    const blacklisted = await BlacklistModel.findOne({ token });
    if (blacklisted) return res.status(403).send('Invalid token');
    const SECRET_KEY = process.env.SECRET_KEY;
  
    jwt.verify(token, SECRET_KEY, (err, user) => {
      if (err) return res.status(403).send('Invalid token');
      req.user = user;
      next();
    });
  }catch (err) {
    return res.status(500).send('Internal Server Error');
  }
    
}



  