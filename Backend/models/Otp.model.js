const mongoose = require("mongoose");

// create a model for the otp
const otpSchema = new mongoose.Schema({
    mobileNumber: {
        type: String,
        required: true
    },
    otp: {
        type: String,
        required: true
    },
    createdAt: {
        type: Date,
        default: Date.now,

        // 5 minute
        expires: 300
    }
});

module.exports = mongoose.model("Otp", otpSchema);