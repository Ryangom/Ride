const mongoose = require("mongoose");

// create a model for the otp
const bidding = new mongoose.Schema({
    driver: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        default: null,
    },
    rentId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "RentCar",
        default: null,
    },
    offeredPrice: {
        type: Number,
        default: 0,
    },
    commisionPercentage: {
        type: Number,
        default: 0,
    },
    taxPercentage: {
        type: Number,
        default: 0,
    },
    vatPercentage: {
        type: Number,
        default: 0,
    },

    createdAt: {
        type: Date,
        default: Date.now,
    }
});

module.exports = mongoose.model("Bidding", bidding);