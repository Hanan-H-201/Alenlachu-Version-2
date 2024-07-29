const BlacklistModel = require("../models/blackList.model");

exports.authenticateToken = async (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
  
    if (!token) return res.status(401).send('Access denied');
  
    const blacklisted = await BlacklistModel.findOne({ token });
    if (blacklisted) return res.status(403).send('Invalid token');
  
    jwt.verify(token, SECRET_KEY, (err, user) => {
      if (err) return res.status(403).send('Invalid token');
      req.user = user;
      next();
    });
  }



  