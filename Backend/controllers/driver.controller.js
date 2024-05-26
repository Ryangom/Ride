const userModel = require('../models/User.model');
const pickupRequest = require('../models/pickUpRequest.model');
const vehicleModel = require('../models/Vehicle.model');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const walletModel = require('../models/wallet.model');
const InterCityRide = require('../models/InterCityRide.model');

class driverController {

    //driver register
    static async driverRegister(req, res) {

        try {
            let nid = 'http://192.168.0.200:5000/images/nID/' + req.files['nID'][0].filename;
            let vehiclePic = 'http://192.168.0.200:5000/images/vehicle_pic/' + req.files['vehicle_pic'][0].filename;
            let registation = 'http://192.168.0.200:5000/images/driving_license/' + req.files['driving_license'][0].filename;
            let license = 'http://192.168.0.200:5000/images/vehicle_registration/' + req.files['vehicle_registration'][0].filename;

            let user = JSON.parse(req.body['user']);
            let userPass = user.password;


            // check if user already exists
            // const checkMobile = await userModel.findOne({ mobileNumber: user.mobileNumber });
            // if (checkMobile) {
            //     return res.status(400).json({
            //         status: 'failed',
            //         message: 'Phone number already exists'
            //     });
            // }

            // hash the password
            const salt = await bcrypt.genSalt(10);
            const hashPassword = await bcrypt.hash(userPass, salt);

            const newUser = new userModel({
                ...user,
                image: 'http://192.168.0.200:5000/images/nID/1693552552216NID.jpg',
                password: hashPassword,
                vehicle: null,
                idCard: nid,
                drivingLivence: registation,
                vehicleRegistration: license,

            });
            let data = await newUser.save();



            if (data) {

                //create wallet
                const wallet = new walletModel({
                    driver: data._id,
                    balance: 0,
                    totalEarning: 0,
                    adminDue: 0
                });
                await wallet.save();



                const vehicle = new vehicleModel({
                    ...user.vehicle,
                    vehicleOwner: data.id,
                    image: vehiclePic,
                });
                let vehicleData = await vehicle.save();

                //update user vehicle
                if (vehicleData) {
                    userModel.findByIdAndUpdate(data.id, {
                        $set: {
                            vehicle: vehicleData.id,
                        }
                    }, { new: true }, (err, doc) => {
                        if (err) {
                            console.log("Something wrong when updating data!");
                        }

                        else {
                            return res.status(200).json({
                                status: 'success',
                                data: doc
                            });
                        }
                    });
                }

            }
        }

        catch (error) {
            res.status(100).json({
                message: 'Error Occured in login process',
                error
            })
            console.log(error);
        }
    }

    static async driverUpdateVehicle(req, res) {
        const id = req.params.id;
        let vehicle_pic = "http://192.168.0.200:5000/images/vehicle_pic/" + req.files.vehicle_pic[0].filename;
        let driving_license = "http://192.168.0.200:5000/images/driving_license/" + req.files.driving_license[0].filename;
        let vehicle_registration = "http://192.168.0.200:5000/images/vehicle_registration/" + req.files.vehicle_registration[0].filename;




        try {
            const vehicle = new vehicleModel({
                ...req.body,
                vehicleOwner: id,
                vehicle_pic,
                driving_license,
                vehicle_registration,
            });
            let data = await vehicle.save();

            await userModel.findByIdAndUpdate(id, {
                $set: {
                    vehicle: data.id,
                }
            })




            if (!data) {
                return res.status(404).json({ status: "failed", message: "Something went worng!", })
            }
            else {
                return res.status(200).json({
                    status: 'success',
                    data: data
                });

            }




        } catch (error) {
            res.status(500).json({
                message: 'Error Occured in login process',
                error
            })
        }
    }
    //driver find near by pickup request
    static async driverFindNearByPickupRequest(req, res) {

        const driverId = req.params.id;
        try {
            const user = await pickupRequest.find({
                riderInRange: driverId
            },
                // dont show password and location type
                { password: 0 },
            );

            if (!user) {
                return res.status(404).json({ status: "failed", message: "User not found", })
            }
            else {
                return res.status(200).json({
                    status: 'success',
                    message: 'Active pickup requests in your area',
                    data: user
                });
            }

        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }





    }


    //Driver get basic Stats like acceptance rate, total earning, total rides, rating 
    static async driverGetStats(req, res) {
        const driverId = req.params.id;
        let wallet = await walletModel.findOne({ driver: driverId }, { totalEarning: 1, _id: 0 });
        let rent = await InterCityRide.find({ driver: driverId, status: "completed" });
        let rating = [3, 5, 3, 4, 1, 4, 5, 3, 4, 5, 3, 4, 5, 3, 4, 5]
        let avgRating = rating.reduce((a, b) => a + b, 0) / rating.length;


        let totalRides = rent.length;
        let totalAcceptance = 2;
        let totalAcceptanceRate = (totalAcceptance / totalRides) * 100;
        if (totalAcceptanceRate == Infinity) {
            totalAcceptanceRate = 0;
        }






        try {


            res.status(200).json({
                status: 'success',
                data: {
                    acceptanceRate: totalAcceptanceRate.toFixed(1),
                    totalEarning: wallet.totalEarning || 0,
                    totalRides: totalRides,
                    adminDue: wallet.adminDue || 0,
                    rating: avgRating.toFixed(1),
                }
            });
        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }


}

module.exports = driverController;