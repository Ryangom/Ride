const mongoose = require('mongoose');

const ComplainSchema = new mongoose.Schema({

    name: {
        type: String,
        default: '',
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
    },
    subject: {
        type: String,
        default: '',
    },
    complain: {
        type: String,
        default: '',
    },

    createdAt: {
        type: Date,
        default: Date.now
    },
});

module.exports = mongoose.model('Complain', ComplainSchema);