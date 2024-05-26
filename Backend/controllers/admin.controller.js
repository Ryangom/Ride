const userModel = require('../models/User.model');
const pickupRequest = require('../models/pickUpRequest.model');
const vehicleModel = require('../models/Vehicle.model');
const feedbackModel = require('../models/feedback.model');
const adminShareModel = require('../models/adminShare');

const rentModel = require('../models/InterCityRide.model');
const InterCityRide = require('../models/InterCityRide.model');
const walletModel = require('../models/wallet.model');
const complain = require('../models/complain');
const emergency = require('../models/emergency');
class adminController {
    static async adminAddUser(req, res) {

        const data = req.body.user;
        const userData = JSON.parse(data);
        let fileName = 'http://192.168.0.200:5000/images/profile_pic/' + req.file.filename;

        const user = new userModel({
            ...userData,
            image: fileName
        })
        user.save()
            .then(user => {
                res.status(200).json({
                    status: 'success',
                    user
                })
            })
            .catch(err => {
                res.status(500).json({
                    message: 'Error Occured',
                    err
                })
                console.log(err);
            })
    }


    static async adminUpdateUser(req, res) {

    }


    // Delete a User
    static async deleteUser(req, res) {


        console.log(req.params.id);

        try {


            let vehicle = await vehicleModel.findOne({ vehicleOwner: req.params.id });
            if (vehicle) {
                let vehicleId = vehicle._id;
                let vehicleDeleted = await vehicleModel.findByIdAndDelete(vehicleId);
                if (vehicleDeleted) {
                    let userDeleted = await userModel.findByIdAndDelete(req.params.id);
                    if (userDeleted) {
                        res.status(200).json({
                            status: 'success',
                            message: 'User Deleted',
                            userDeleted
                        })
                    }
                }
            }
            else {
                let userDeleted = await userModel.findByIdAndDelete(req.params.id);
                if (userDeleted) {
                    res.status(200).json({
                        status: 'success',
                        message: 'User Deleted',
                        userDeleted
                    })
                }
            }


        }
        catch (error) {

        }

        // userModel.findByIdAndDelete(req.params.id)
        //     .then(user => {
        //         res.status(200).json({
        //             status: 'success',
        //             message: 'User Deleted',
        //             user
        //         })
        //     })
        //     .catch(err => {
        //         res.status(500).json({
        //             status: 'failed',
        //             message: 'Error Occured',
        //             err
        //         })
        //     })
    }




    static async adminGetAllVehicle(req, res) {
        const result = await vehicleModel.find({}).populate('vehicleOwner');
        res.status(200).json({
            status: 'success',
            data: result
        })
    }

    static async adminGetsAllFeedback(req, res) {
        feedbackModel.find().populate('user').populate('driver')
            .then(feedbacks => {
                res.status(200).json({
                    status: 'success',
                    feedbacks
                })
            })
            .catch(err => {
                res.status(500).json({
                    message: 'Error Occured',
                    err
                })
            })
    }
    //report
    static async adminDownoadUserReport(req, res) {

        let userType = req.params.userType;

        try {
            let data = await userModel.find({ role: userType });

            // make this data to new array
            let newData = [];
            data.forEach(element => {
                let { _id, location, ...rest } = element._doc;
                let obj = {
                    ...rest,
                    lat: location.coordinates[1],
                    lng: location.coordinates[0]
                }
                newData.push(obj);
            });



            if (!data) {
                return res.status(404).json({ status: "failed", message: "Something went worng!", })
            }
            else {
                return res.status(200).json({
                    status: 'success',
                    data: newData
                });

            }
        } catch (error) {
            res.status(500).json({
                message: 'Error Occured',
                error
            })

        }

    }
    //get basic info for admin dashboard(not completed)
    static async adminGetsBasicInfo(req, res) {
        try {
            var user = await userModel.find({ role: 'user' });
            var driver = await userModel.find({ role: 'driver' });
            var pickupRequests = await pickupRequest.find({});
            var InterCityRides = await InterCityRide.find({});
            var Wallet = await walletModel.findOne({
                _id: '6547474e39e95c0c13382c0a'
            });
            res.status(200).json({
                status: 'success',
                data: {
                    userCount: user.length,
                    driverCount: driver.length,
                    pickupRequestCount: pickupRequests.length,
                    interCityRides: InterCityRides.length,
                    totalEarning: Wallet.totalEarning,
                }
            })

        } catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });

        }
        // var pickupRequest= pickupRequestModel.find({});
        // var completedPickupRequest= pickupRequestModel.find({ status: 'completed' });





    }
    // get all users 
    static async adminGetAllUsers(req, res) {
        try {
            const users = await userModel.find({
                "role": "user"
            }); // retrieve all users
            res.status(200).json({
                message: "Users retrieved successfully",
                data: users,
                status: "success"
            });
        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }
    static async adminGetAllDriver(req, res) {
        try {
            const driver = await userModel.find({
                "role": "driver"
            }).populate('vehicle'); // retrieve all users
            res.status(200).json({
                message: "Users retrieved successfully",
                data: driver,
                status: "success"
            });
        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }

    // AdminShare & Admin Earning/ Settting

    static async adminGetsAdminShare(req, res) {

        try {
            let result = await adminShareModel.findOne({
                _id: '650da0aec4c443d96357294f'
            });
            if (result) {
                res.status(200).json({
                    status: 'success',
                    data: result
                })

            }
        }



        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }

    static async updateAdminSharePerRide(req, res) {

        try {



            let result = await adminShareModel.findByIdAndUpdate('650da0aec4c443d96357294f', {
                $set: {
                    commisionPercentage: req.body.commisionPercentage,
                    vatPercentage: req.body.vatPercentage,
                    taxPercentage: req.body.taxPercentage,

                }
            });


            if (result) {
                res.status(200).json({
                    status: 'success',
                    data: result
                })
            }


            // let result = adminShareModel.findByIdAndUpdate(id, {
            //     $set: {


            //     }
            // });

            // if (result) {
            //     res.status(200).json({
            //         status: 'success',
            //         data: result
            //     })
            // }




        }
        catch (error) {
            console.log(error);
            // return res.status(500).json({ message: "Internal server error" });
        }

    }


    static async adminGetAllBookings(req, res) {
        try {
            let result = await rentModel.find({}).populate('customer').populate('driver');





            if (result) {
                res.status(200).json({
                    status: 'success',
                    data: result
                })
            }
        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });

        }
    }

    static async adminGetAllComplain(req, res) {
        try {
            let result = await complain.find({}).populate('user');

            if (result) {
                res.status(200).json({
                    status: 'success',
                    data: result
                })
            }
        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });

        }
    }


    static async adminGetsEmergency(req, res) {
        try {
            const emergencyData = await emergency.find({}); // retrieve all users
            if (emergencyData) {

                res.status(200).json({
                    message: "Emergency retrieved successfully",
                    data: emergencyData,
                    status: "success"
                });
            }
            else {
                res.status(404).json({
                    message: "Emergency not found",
                    status: "failed"
                });
            }
        } catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }
    static async adminGetsEmergencyUpdate(req, res) {
        try {
            const emergencyData = await emergency.findByIdAndUpdate(req.body._id, {
                $set: {
                    status: req.body.status
                }
            });

            if (emergencyData) {

                res.status(200).json({
                    message: "Emergency retrieved successfully",
                    data: emergencyData,
                    status: "success"
                });
            }
            else {
                res.status(404).json({
                    message: "Emergency not found",
                    status: "failed"
                });
            }

        } catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }

}



module.exports = adminController;

