
const mongoose = require('mongoose');

const walletSchema = new mongoose.Schema({
    driver: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    balance: {
        type: Number,
        default: 0
    },
    totalEarning: {
        type: Number,
        default: 0
    },
    adminDue: {
        type: Number,
        default: 0
    },
});


module.exports = mongoose.model('Wallet', walletSchema);