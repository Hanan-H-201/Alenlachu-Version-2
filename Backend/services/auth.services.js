const jwt = require('jsonwebtoken');
class Authentication {
    static async generateToken(tokenData, secretKey, jwt_expire){
        return jwt.sign(tokenData, secretKey, {expiresIn : jwt_expire});
    }
}

module.exports = Authentication;