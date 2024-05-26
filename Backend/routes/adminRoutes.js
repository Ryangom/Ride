// make routes for the application 
const express = require('express');
const router = express.Router();
const upload_multer = require('../middlewares/fileUpload');

// import the controller
const adminController = require('../controllers/admin.controller');
const userController = require('../controllers/user.controller');



router.post('/adminAddUser', upload_multer.single('profile_pic'), adminController.adminAddUser);
router.post('/adminDeleteUser/:id', adminController.deleteUser);


router.get('/adminGetsAllUser/:role', userController.adminGetsAllUsers);



router.get('/adminGetsAdminShare', adminController.adminGetsAdminShare);
router.post('/adminUpdateAdminShare', adminController.updateAdminSharePerRide);



router.get('/getAllVehicle', adminController.adminGetAllVehicle);
router.get('/getAllFeedbacks', adminController.adminGetsAllFeedback);
router.get('/adminDownoadUserReport/:userType', adminController.adminDownoadUserReport);
router.get('/adminGetsBasicInfos', adminController.adminGetsBasicInfo);
router.get('/adminGetAllBookings', adminController.adminGetAllBookings);
router.get('/adminGetAllComplain', adminController.adminGetAllComplain);
router.get('/adminGetsEmergency', adminController.adminGetsEmergency);
router.post('/adminGetsEmergencyUpdate', adminController.adminGetsEmergencyUpdate);

//export the router
module.exports = router;







