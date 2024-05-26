const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const vehicleSchema = new Schema({
    name: {
        type: String,
    },
    plateNumber: {
        type: String,
    },
    color: {
        type: String,
    },
    image: {
        type: String,
    },

    vehicleOwner: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        default: null
    },
    createdAt: {
        type: Date,
        default: Date.now
    },
});

module.exports = mongoose.model('Vehicle', vehicleSchema);

