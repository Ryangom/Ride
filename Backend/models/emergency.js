const mongoose = require('mongoose');

const EmergencySchema = new mongoose.Schema({

    name: {
        type: String,
        default: '',
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        default: null
    },
    phone: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: '',
    },
    helpType: {
        type: String,
        default: '',
    },
    location: {
        type: String,
        default: '',
    },
    requestTime: {
        type: Date,
        default: Date.now
    },
    status: {
        type: String,
        default: 'onGoing',
    },
    createdAt: {
        type: Date,
        default: Date.now
    },

});

module.exports = mongoose.model('Emergency', EmergencySchema);