// create a express server 
const express = require('express');
const app = express();
const bcrypt = require('bcrypt');
// // config env
require('dotenv').config();


process.env.TZ = 'Asia/Dhaka';

require('./config/DB_conn');
const port = process.env.PORT || 5000;
const cors = require('cors');

const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const adminRoutes = require('./routes/adminRoutes');
const driverRoutes = require('./routes/driverRoute');
// // cors middleware
app.use(cors());

// // JSON middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


// // Routes
app.use('/api/auth', authRoutes);
app.use('/api/user', userRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/driver', driverRoutes);
app.use("/images", express.static('uploads'));



const Rent = require('./models/InterCityRide.model');
const biddingModel = require('./models/bidding.model');

// user create rent request
app.post('/rent', async (req, res) => {

    const newRent = new Rent({
        ...req.body,
        status: "active",
        createdAt: Date.now()
    });

    try {

        const savedRent = await newRent.save();
        if (savedRent) {
            res.status(200).json({
                status: "success",
                message: "Rent created successfully",
            });
        } else {
            res.status(400).json({
                status: "fail",
                message: "Rent not created",
            });
        }

    } catch (error) {
        console.log(error);
    }
});

//user Check curent active rent by user id
app.get('/checkRent/:id', async (req, res) => {

    try {
        const rent = await Rent.findOne({ customer: req.params.id, status: "active" });
        if (rent) {
            if (rent.bided.length > 0) {

                rent.bided = await biddingModel.find({ _id: { $in: rent.bided } }).populate('driver');

                res.status(200).json({
                    status: "success",
                    length: rent.length,
                    data: rent
                });

            } else {
                res.status(200).json({
                    status: "success",
                    length: rent.length,
                    data: rent
                });
            }



        } else {
            res.status(200).json({
                status: "fail",
                data: rent
            });
        }


    } catch (error) {
        console.log(error);
    }
});


// user accept driver bid 
app.post('/userAcceptRentOffer', async (req, res) => {


    try {
        const findRent = await Rent.findById(req.body.rentId);

        if (findRent) {
            // update the status and add driver id
            findRent.status = "accepted";
            findRent.driver = req.body.driverId;
            findRent.commision = req.body.commision;
            findRent.tax = req.body.tax;
            findRent.vat = req.body.vat;
            findRent.totalPrice = req.body.totalPrice;

            const savedRent = await findRent.save();
            if (savedRent) {
                res.status(200).json({
                    status: "success",
                    message: "Rent accepted successfully",
                });
            }
        } else {
            res.status(400).json({
                status: "fail",
                message: "Rent not found",
            });
        }
    } catch (error) {
        console.log(error);
    }
});






//driver ==================



//driver finds intercity request to bid
app.get('/driverFindRents', async (req, res) => {

    try {
        const rent = await Rent.find({ status: "active" }).populate('customer');

        if (rent.length > 0) {

            for (let i = 0; i < rent.length; i++) {
                rent[i].bided = await biddingModel.find({ _id: { $in: rent[i].bided } });
            }

            //desanding order by createdAt
            rent.sort((a, b) => b.createdAt - a.createdAt);
            res.status(200).json({
                status: "success",
                length: rent.length,
                data: rent
            });
        }



    } catch (error) {
        console.log(error);
    }
});


//driver bid on intercity ride request
app.post('/driverBidonRent', async (req, res) => {
    const { rentId, bidAmount, driverId } = req.body;

    try {
        const rent = await Rent.findById(rentId);
        if (rent) {

            const Bidding = require('./models/bidding.model');
            const bidding = new Bidding({
                driver: driverId,
                offeredPrice: bidAmount,
                rentId: rentId,
                commisionPercentage: req.body.commisionPercentage,
                taxPercentage: req.body.taxPercentage,
                vatPercentage: req.body.vatPercentage,
                createdAt: Date.now()
            });

            const savedBidding = await bidding.save();
            if (savedBidding) {
                rent.bided.push(savedBidding._id);
                const savedRent = await rent.save();
                res.status(200).json({
                    status: "success",
                    message: "Bid created successfully",
                    data: savedRent
                });
            }

        } else {
            res.status(400).json({ message: "Rent not found" });
        }
    } catch (error) {
        console.log(error);
    }
});
// driver find active intercity by id    
app.get('/driverGetRentInfo/:id', async (req, res) => {

    try {
        const rent = await Rent.findById(req.params.id).populate('customer');

        if (rent) {


            rent.bided = await biddingModel.find({ _id: { $in: rent.bided } });

            res.status(200).json({
                status: "success",
                data: rent
            });
        }



    } catch (error) {
        console.log(error);
    }
});

// that means driver accept the intercity request and it will show him in his intercity list panel
app.get('/driverFindAcceptedRents/:driverId', async (req, res) => {

    try {
        const rent = await Rent.find({ driver: req.params.driverId, status: "accepted" }, {
            bided: 0,
        }).populate('customer');

        if (rent) {
            res.status(200).json({
                status: "success",
                length: rent.length,
                data: rent
            });
        }
    }
    catch (error) {
        console.log(error);
    }
});




//admin Finds all intercity
app.get('/adminFindsAllRents', async (req, res) => {

    try {
        const rent = await Rent.find().populate('customer');
        res.status(200).send({
            status: "success",
            length: rent.length,
            data: rent
        });

    } catch (error) {
        console.log(error);
    }
});



// start the server
app.listen(port, () => console.log(`Server listening on port ${port}`));


