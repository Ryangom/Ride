
const mongoose = require('mongoose');

const adminShare = new mongoose.Schema({
    commisionPercentage: {
        type: Number,
        default: 0
    },
    vatPercentage: {
        type: Number,
        default: 0
    },
    taxPercentage: {
        type: Number,
        default: 0
    },

});

module.exports = mongoose.model('AdminShare', adminShare);
