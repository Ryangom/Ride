// make routes for the application 
const express = require('express');
const driverController = require('../controllers/driver.controller');
const interCityRides = require('../controllers/interCityRide.controller');
const router = express.Router();





router.get('/driverStats/:id', driverController.driverGetStats);


router.post('/driverCompleteIntercityRide/:id', interCityRides.driverCompleteIntercityRide);



module.exports = router;

// router.get('/driverFindsPickupRequest/:id', userController.driverFindNearByPickupRequest);