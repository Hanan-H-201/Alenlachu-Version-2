const jwt = require('jsonwebtoken');
class Authentication {
    static generateToken(tokenData, secretKey, options){
        return jwt.sign(tokenData, secretKey, options);
    }
}

module.exports = Authentication;