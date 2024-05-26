// make routes for the application 
const express = require('express');
const router = express.Router();
const upload_multer = require('../middlewares/fileUpload');
// import the controller
const authController = require('../controllers/auth.controller');
const driverController = require('../controllers/driver.controller');



//public routes

//register user
router.post('/register', authController.register);
//driver register
let driverFiles = upload_multer.fields([{ name: 'nID' }, { name: 'vehicle_pic' }, { name: 'driving_license' }, { name: 'vehicle_registration' }]);
router.post('/driverRegister', driverFiles, driverController.driverRegister);

//login user
router.post('/login', authController.login);
router.post('/forgotPassword', authController.forgotPassword);
router.post('/verifyOtp', authController.verifyOtp);
router.post('/savePass', authController.saveForgotPassword);






//export the router
module.exports = router;







