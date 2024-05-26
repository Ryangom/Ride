const mongoose = require('mongoose');

date = new Date();

const InterCityRides = new mongoose.Schema({

    pickupLocationEn: {
        type: String,
        default: '',
    },
    pickupLocationGeoCode: {
        type: {
            type: String,
            enum: ['Point'],
            default: 'Point'
        },
        coordinates: {
            type: [Number],
            index: '2dsphere',
            default: [0, 0]
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
            default: 'Point'
        },
        coordinates: {
            type: [Number],
            index: '2dsphere',
            default: [0, 0]
        }
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

    bided: [],
    totalPrice: {
        type: String,
        default: ''
    },
    distance: {
        type: String,
        default: ''
    },
    scheduledTime: {
        type: String,
        default: ''
    },
    vat: {
        type: Number,
        default: 0
    },
    tax: {
        type: Number,
        default: 0
    },
    commision: {
        type: Number,
        default: 0
    },
    createdAt: {
        type: Date,
        default: Date.now()
    },
    eta: {
        type: String,
        default: ''
    },
    type: {
        type: String,
        default: 'interCity'
    },
    status: {
        type: String,
        default: ''
    },
});

const InterCityRide = mongoose.model('InterCityRides', InterCityRides);

module.exports = InterCityRide;
