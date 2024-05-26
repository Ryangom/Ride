const userModel = require('../models/User.model');
const otpModel = require('../models/Otp.model');

const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');

class authController {

    // Register User (done)
    static async register(req, res) {
        const { mobileNumber, password, email } = req.body;
        try {
            //validate the user input if empty
            if (!mobileNumber || !password || !email) return res.status(400).json({ message: 'Please enter all fields' }); // check if all fields are entered

            // check if user already exists
            const checkMobile = await userModel.findOne({ mobileNumber });
            if (checkMobile) {
                return res.status(400).json({
                    status: 'failed',
                    message: 'Phone number already exists'
                });
            }

            // hash the password
            const salt = await bcrypt.genSalt(10);
            const hashPassword = await bcrypt.hash(password, salt);

            // create a new user
            const user = new userModel({
                ...req.body,
                password: hashPassword,
            });

            // save the user

            await user.save();
            res.status(200).json({
                status: 'success'
            });
        }
        catch (error) {
            console.error(error.message);
            res.status(500).json({
                message: 'Error occurred in registration process', // fix typo in message
                error
            });
        }
    }
    // Login User (done)
    static async login(req, res) {
        const { mobileNumber, password, role } = req.body;
        try {

            userModel.findOne({ mobileNumber, role }).populate('vehicle') // find user by phone
                .then(user => {
                    if (!user) {
                        return res.status(401).json({
                            status: 'failed',
                            message: 'Mobile number or password is incorrect'
                        })
                    } else {
                        // compare password
                        bcrypt.compare(password, user.password)
                            .then(isMatch => {
                                if (!isMatch) {
                                    return res.status(401).json({
                                        status: 'failed',
                                        message: 'Invalid Credentials'
                                    })
                                } else {
                                    // create a token
                                    const payload = {
                                        id: user.id,
                                        phone: user.phone,
                                        role: user.role,
                                    }

                                    jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: 3600 }, (err, token) => {
                                        if (err) {
                                            throw err;
                                        } else {
                                            res.status(200).json({
                                                status: 'success',
                                                token,
                                                user
                                            })
                                        }
                                    })
                                }
                            })

                    }
                })


        } catch (error) {
            res.status(500).json({
                message: 'Error Occured in login process',
                error
            })
        }
    }
    // forgot password
    static async forgotPassword(req, res) {
        try {
            const { mobileNumber } = req.body;
            // Validate if user input is empty
            if (!mobileNumber) return res.status(400).json({ message: "Mobile number is required" });

            // Check if user exists with the provided email
            const user = await userModel.findOne({ mobileNumber });
            if (!user) {
                return res.status(404).json({ status: "failed", message: "User not found", })
            }
            else {
                let otp = "";
                const possibleChars = "0123456789";
                // Loop 6 times to generate a 6 digit OTP
                for (let i = 0; i < 4; i++) {
                    // Get a random index from possibleChars string
                    const randomIndex = Math.floor(Math.random() * possibleChars.length);
                    // Add the character at that index to the OTP
                    otp += possibleChars.charAt(randomIndex);
                }

                const newOtp = new otpModel({
                    mobileNumber,
                    otp
                });

                // Save the OTP document in the database
                await newOtp.save();

                // Send the OTP to the user's email
                let pass = process.env.NODEMAILER_PASS;
                let transporter = nodemailer.createTransport({
                    service: 'gmail',
                    auth: {
                        user: process.env.NODEMAILER_EMAIL,
                        pass: pass
                    }
                });

                let mailOptions = {
                    from: process.env.NODEMAILER_EMAIL,
                    to: user.email,
                    subject: 'OTP for password reset',
                    text: 'Your OTP is ' + otp
                };

                transporter.sendMail(mailOptions, function (error, info) {
                    if (error) {
                        console.log(error);
                        res.status(500).json({
                            message: 'Error occurred in sending email',
                            error
                        })
                    } else {
                        res.status(200).json({
                            status: 'success',
                            userEmail: user.email,
                            message: `Dear customer OTP successfully sent to your Email: ${user.email}. Please check your email. This OTP will expire in 5 minutes.`,

                        });
                    }
                });

            }

        } catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }
    //check otp
    static async verifyOtp(req, res) {
        const { mobileNumber, otp } = req.body;
        try {
            let verifyOtp = await otpModel.findOne({ mobileNumber, otp }); // find user by phone
            if (!verifyOtp) {
                return res.status(400).json({
                    message: 'Invalid OTP',
                    status: 'failed'
                })
            } else {
                return res.status(200).json({
                    message: 'OTP verified successfully',
                    status: 'success'
                })
            }

        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }
    //reset password after otp verification
    static async saveForgotPassword(req, res) {
        const { mobileNumber, password } = req.body;
        try {
            //update user password
            const salt = await bcrypt.genSalt(10);
            const hashPassword = await bcrypt.hash(password, salt);


            let updatePassword = await userModel.findOneAndUpdate({ mobileNumber }, { password: hashPassword }, { new: true }); // find user by phone
            if (!updatePassword) {
                return res.status(400).json({
                    message: 'Something went wrong',
                    status: 'failed'
                })
            } else {
                return res.status(200).json({
                    message: 'Password updated successfully',
                    status: 'success'
                })
            }

        }
        catch (error) {
            console.log(error);
            return res.status(500).json({ message: "Internal server error" });
        }
    }

}

module.exports = authController;