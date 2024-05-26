
const InterCityRide = require('../models/InterCityRide.model');
const PickupRequest = require('../models/pickUpRequest.model');
const walletModel = require('../models/wallet.model');



class RentController {
    static async getRentRequest(req, res) {
        try {

            const rentRequestDate = await PickupRequest.find();

            res.status(200).json(rentRequestDate);
        } catch (error) {
            res.status(400).json(error.message);
        }
    }

    static async userCreateRentBid(req, res) {


        const newPickupRequest = new PickupRequest({
            ...req.body
        });

        try {
            const savedPickupRequest = await newPickupRequest.save();
            res.status(200).json(savedPickupRequest);
        } catch (error) {
            console.log(error);
        }

    }

    static async driverCompleteIntercityRide(req, res) {
        try {
            let rent = await InterCityRide.findOne({ _id: req.params.id });

            if (rent) {

                const wallet = await walletModel.findOne({ driver: rent.driver });

                if (wallet) {
                    wallet.balance = wallet.balance + Number(rent.totalPrice);
                    wallet.totalEarning = wallet.totalEarning + Number(rent.totalPrice);
                    // wallet.adminDue = wallet.adminDue + rent.adminDue;
                    await wallet.save();

                    rent.status = "completed";
                    await rent.save();
                } else {
                    const newWallet = new walletModel({
                        driver: rent.driver,
                        balance: Number(rent.totalPrice),
                        totalEarning: Number(rent.totalPrice),
                        adminDue: rent.adminDue
                    });
                    await newWallet.save();
                    rent.status = "completed";
                    await rent.save();

                }

                res.status(200).json({
                    status: "success",
                    message: "Rent completed successfully",
                });
            }

        } catch (error) {
            console.log(error);
        }
    }

}



module.exports = RentController;