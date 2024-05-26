// make model for user 

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true
    },
    address: {
        type: String,

    },
    image: {
        type: String, default: '',
    },

    password: {
        type: String,
        required: true
    },
    location: {
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
    mobileNumber: {
        type: String,
        required: true
    },
    vehicle: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Vehicle',
        default: null
    },
    idCard: {
        type: String,
        default: ''
    },
    drivingLivence: {
        type: String,
        default: ''

    },
    vehicleRegistration: {
        type: String,
        default: ''
    },
    role: {
        type: String
    },
    rating: {
        type: Number,
        default: 0
    },

    status: {
        type: String,
        default: 'active'
    },

    createdAt: {
        type: Date,
        default: Date.now
    },
});

// userSchema.index({ location: "2dsphere" });

const User = mongoose.model('User', userSchema);

module.exports = User;
