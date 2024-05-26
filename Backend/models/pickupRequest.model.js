const mongoose = require('mongoose');

const PickupRequestSchema = new mongoose.Schema({

    pickupLocationEn: {
        type: String,
        default: '',
    },
    pickupLocationGeoCode: {
        type: {
            type: String,
            enum: ['Point'],
        },
        coordinates: {
            type: [Number],
            index: '2dsphere'
        }
    },

    destinationEn: {
        type: String,
        default: '',
    },
    destinationGeoCode: {
        type: {
            type: String,
            enum: ['Point'],
        },
        coordinates: {
            type: [Number],
            index: '2dsphere'
        }
    },
    requestTime: {
        type: Date,
        default: Date.now
    },
    pickupTime: {
        type: Date,
        default: ''
    },
    customer: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        default: null
    },
    //make rider null at first
    driver: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        default: null
    },
    driverInRange: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User',
            default: null,
        }
    ],
    type: {
        type: String,
        default: 'pickup'
    },
    status: {
        type: String,
        default: ''
    },
});

const PickupRequest = mongoose.model('PickupRequest', PickupRequestSchema);

module.exports = PickupRequest;
