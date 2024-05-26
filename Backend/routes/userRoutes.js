// make routes for the application 
const express = require('express');
const router = express.Router();
const userController = require('../controllers/user.controller');
const token = require('../middlewares/token');
const upload_multer = require('../middlewares/fileUpload');
const RentController = require('../controllers/interCityRide.controller');
//private route

router.get('/getUserProfile/:id', userController.getUserProfile);

router.post('/userUpdateUserLocation/:id', userController.userUpdateUserLocation);

router.post('/updateUserProfile', upload_multer.single('profile_pic'), userController.updateUser);

router.post('/userRequestForPickup', userController.userRequestForPickup);
// //feedback
router.post('/userGiveFeedback', userController.userGiveFeedback);


router.get('/userGetVehicleInfo/:driverId', userController.userGetVehicleInfo);
router.get('/userGetHistory/:userId', userController.userGetHistory);
router.get('/userGetHistoryDetails/:rideId', userController.userGetHistoryDetails);
router.get('/userGetAdminShareInfo', userController.userGetAdminShareInfo);
router.get('/getMyBookedIntercityRides/:userId', userController.getMyBookedIntercityRides);
router.get('/userGetRideInfo/:rideId/:rideType', userController.userGetRideInfo);
router.post('/complain', userController.userComplain);
router.post('/userCreateEmergency', userController.userCreateEmergency);





// router.get('/rent', CarRentController.getRentRequest);
router.post('/rentPost', RentController.userCreateRentBid);
















module.exports = router;