const userModel = require('../models/User.model');
const pickupRequest = require('../models/pickUpRequest.model');
const feedbackModel = require('../models/feedback.model');
const vehicleModel = require('../models/Vehicle.model');
const InterCityRide = require('../models/InterCityRide.model');
const AdminShare = require('../models/adminShare');
const Complain = require('../models/complain');
const emergency = require('../models/emergency');
class userController {

    // Get a User Profile
    static async getUserProfile(req, res) {
        userModel.findById(req.params.id)
            .then(user => {
                if (user !== null) {
                    res.status(200).json({
                        status: 'success',
                        data: user
                    })
                } else {
                    res.status(404).json({
                        status: 'failed',
                        message: 'User Not Found'
                    })
                }
            })
            .catch(err => {
                console.log(err);
            })
    }

    //update user profile
    static async updateUser(req, res) {
        let user = req.body['user'];
        let user1 = JSON.parse(user);

        try {
            if (req.file != undefined) {
                let fileName = 'http://192.168.0.200:5000/images/profile_pic/' + req.file.filename;

                const data = await userModel.findByIdAndUpdate(user1._id, {
                    $set: {
                        ...user1,
                        image: fileName
                    }
                });

                if (data) {
                    await userModel.findById(user1._id).then(user => {
                        res.status(200).json({
                            status: 'success',
                            user
                        })
                    })
                }


            }
            else {

                const data = await userModel.findByIdAndUpdate(user1._id, {
                    $set: {
                        ...user1,
                    }
                });

                if (data) {
                    await userModel.findById(user1._id).then(user => {
                        res.status(200).json({
                            status: 'success',
                            user
                        })
                    })
                }
            }
        } catch (error) {
            console.log(error);
        }

    }


    // user update his/her password {Profile Page}
    static async userUpdateUserPassword(req, res) {
        try {
            const userId = req.params.userId;

            const { currentPassword, newPassword } = req.body;
            if (!currentPassword || !newPassword) {
                return res.status(400).json({ message: 'Both the current and new passwords are required' });
            }
            const user = await User.findById(userId);
            const passwordMatch = await bcrypt.compare(currentPassword, user.password);
            if (!passwordMatch) {
                return res.status(401).json({ message: 'Current password is incorrect' });
            }
            const saltRounds = 10;
            const hashedNewPassword = await bcrypt.hash(newPassword, saltRounds);
            user.password = hashedNewPassword;
            await user.save();

            return res.sendStatus(204);
        } catch (error) {

            console.error(error);
            return res.status(500).json({ message: 'Error updating password' });
        }
    }

    //user only update profile picture
    static async userUpdateProfilePicture(req, res) {

        let id = req.params.id;
        let fileName = 'http://192.168.0.200:5000/images/profile_pic/' + req.file.filename;

        userModel.findByIdAndUpdate(id, {
            $set: {
                image: fileName,
            }
        })
            .then(user => {
                res.status(200).json({
                    status: 'success',
                    image: fileName
                })
            })
            .catch(err => {
                res.status(500).json({
                    status: 'failed',
                    message: 'Error Occured',
                    err
                })
            })
    }

    //user update his/her location
    static userUpdateUserLocation(req, res) {
        const id = req.params.id;
        userModel.findByIdAndUpdate(id, {
            $set: {
                location: {
                    type: "Point",
                    coordinates: [req.body.longitude, req.body.latitude]
                }
            }
        }).then(user => {
            res.status(200).json({
                status: 'success',
            })
        })
            .catch(err => {
                res.status(500).json({
                    message: 'Error Occured',
                    err
                })
            })
    }
    // User give feedback on a ride
    static async userGiveFeedback(req, res) {

        try {
            const feedback = new feedbackModel({
                ...req.body,
            });
            let result = await feedback.save();

            if (result) {
                res.status(200).json({
                    status: 'success',
                    message: 'Feedback submitted successfully'
                });
            }
            else {
                res.json({
                    status: 'failed',
                    message: 'Internal server error'
                });
            }



        } catch (err) {
            res.status(500).json({
                message: 'Internal server error'
            });

            console.log(err);
        }



    }

    // Use get driver Vehicle
    static async userGetVehicleInfo(req, res) {
        let driverId = req.params.driverId;

        try {

            let vehicleInfo = (await vehicleModel.findOne({ vehicleOwner: driverId }, { __v: 0 }));
            if (vehicleInfo) {
                return res.status(200).json({
                    status: 'success',
                    data: vehicleInfo
                });
            } else {
                return res.status(404).json({
                    status: 'failed',
                    message: 'No data found'
                });
            }


        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }




    // get ride info
    static async userGetRideInfo(req, res) {
        let rideId = req.params.rideId;
        let rideType = req.params.rideType;


        try {
            if (rideType == 'intercity') {
                let rideInfo = (await InterCityRide.findOne({ _id: rideId }, { __v: 0 }).populate('driver'));
                if (rideInfo) {
                    return res.status(200).json({
                        status: 'success',
                        data: rideInfo
                    });
                } else {
                    return res.status(404).json({
                        status: 'failed',
                        message: 'No data found'
                    });
                }
            }
            else {
                let rideInfo = (await pickupRequest.findOne({ _id: rideId }, { __v: 0 }).populate('driver'));
                if (rideInfo) {
                    return res.status(200).json({
                        status: 'success',
                        data: rideInfo
                    });
                } else {
                    return res.status(404).json({
                        status: 'failed',
                        message: 'No data found'
                    });
                }

            }
        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }






    // Use get driver Vehicle
    static async userGetHistory(req, res) {
        let userId = req.params.userId;

        try {

            // query two document from two collection
            let InterCityRides = (await InterCityRide.find({ customer: userId, status: 'completed' }, { __v: 0 }).populate('driver'));
            let pickupRequests = (await pickupRequest.find({ customer: userId, status: 'completed' }, { __v: 0 }).populate('driver'));

            let history = [...InterCityRides, ...pickupRequests];

            if (history) {
                return res.status(200).json({
                    status: 'success',
                    data: history
                });
            } else {
                return res.status(404).json({
                    status: 'failed',
                    message: 'No data found'
                });
            }



        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }


    static async userGetHistoryDetails(req, res) {
        let rideId = req.params.rideId;

        try {

            // query two document from two collection
            let InterCityRides = (await InterCityRide.findOne({ _id: rideId, status: 'completed' }, { __v: 0 }).populate('driver'));

            if (!InterCityRides) {

                let pickupRequests = (await pickupRequest.findOne({ _id: rideId, status: 'completed' }, { __v: 0 }).populate('driver'));

                if (pickupRequests) {
                    return res.status(200).json({
                        status: 'success',
                        data: pickupRequests
                    });
                }

            }
            else {
                return res.status(200).json({
                    status: 'success',
                    data: InterCityRides
                });
            }
        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }

    static async userGetAdminShareInfo(req, res) {
        try {
            var result = await AdminShare.findOne({});
            if (result) {
                return res.status(200).json({
                    status: 'success',
                    data: result
                });
            }


        } catch (error) {
            return res.status(500).json({ message: "Internal server error" });
        }
    }

    static async getMyBookedIntercityRides(req, res) {
        try {
            let userId = req.params.userId;
            let bookedRides = await InterCityRide.find({ customer: userId, status: 'accepted' }, { __v: 0 }).populate('driver');
            if (bookedRides) {
                return res.status(200).json({
                    status: 'success',
                    length: bookedRides.length,
                    data: bookedRides
                });
            }
            else {
                return res.status(404).json({
                    status: 'failed',
                    message: 'No data found'
                });
            }
        } catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }



    static async userComplain(req, res) {
        try {
            const complain = req.body;

            const user = await userModel.findById(req.body.userId);

            if (!user) {
                return res.status(404).json({ message: 'User not found' });
            }

            const complainData = new Complain({
                ...complain,
                user: req.body.userId
            });

            const complainResult = await complainData.save();

            if (complainResult) {
                return res.status(200).json({
                    status: 'success',
                    message: 'Complain submitted successfully'
                });
            }
            else {
                return res.status(404).json({
                    status: 'failed',
                    message: 'No data found'
                });
            }

        } catch (error) {
            console.error(error);
            return res.status(500).json({ message: 'Error updating complain' });
        }
    }

    static async userCreateEmergency(req, res) {
        try {
            const emergencyData = new emergency({
                ...req.body,
            });


            const emergencyResult = await emergencyData.save();

            if (emergencyResult) {
                return res.status(200).json({
                    status: 'success',
                    message: 'Emergency submitted successfully'
                });
            }
            else {
                return res.status(404).json({
                    status: 'failed',
                    message: 'No data found'
                });
            }

        } catch (error) {

        }
    }






    // ==========================Ride related works==============================

    // user request for pickup
    static async userRequestForPickup(req, res) {
        try {
            const { pickupLocationGeoCode } = req.body;

            //     //search near by drivers
            const user = await userModel.find({
                location: {
                    $near: {
                        $geometry: {
                            type: "Point",
                            coordinates: [pickupLocationGeoCode.coordinates[0], pickupLocationGeoCode.coordinates[1]]
                        },
                        $maxDistance: 100,
                    },
                },
                role: 'driver'
            },
                // dont show password and location type
                { password: 0 },
            );

            let driverId = [];
            user.forEach(element => {
                driverId.push(element.id);
            });

            const PickupRequest = new pickupRequest({
                ...req.body,
                riderInRange: driverId
            });

            const PickupRequestData = await PickupRequest.save();

            if (!PickupRequestData) {
                return res.status(404).json({ status: "failed", message: "No data found", })
            }
            else {
                return res.status(200).json({
                    status: 'success',
                    data: PickupRequestData
                });

            }

        } catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }

    // ==========================Admin==============================
    static async adminGetsAllUsers(req, res) {
        let userType = req.params.role;

        try {
            let users = (await userModel.find({ role: userType }, { password: 0, __v: 0 }).populate('vehicle'));
            if (users) {

                return res.status(200).json({
                    status: 'success',
                    length: users.length,
                    data: users
                });
            }
            else {
                return res.status(404).json({
                    status: 'failed',
                    message: 'No data found'
                });
            }
        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }









}

module.exports = userController;

