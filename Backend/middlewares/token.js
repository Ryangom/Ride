//check jwt token middleware
const jwt = require('jsonwebtoken');



module.exports = (req, res, next) => {
    const token = req.headers.authorization.split(' ')[2];
    if (token) {

        jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
            if (err) {
                return res.status(401).json({
                    success: false,
                    message: 'Token is not valid'
                });
            } else {
                req.decoded = decoded;
                next();
            }
        }
        );
    } else {
        return res.status(401).json({
            success: false,
            message: 'Auth token is not supplied'
        });
    }
};