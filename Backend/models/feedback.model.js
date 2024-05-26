const mongoose = require('mongoose');

const FeedbackSchema = new mongoose.Schema({

    feedback: {
        type: String,
        default: '',
    },
    rating: {
        type: Number,
        default: 0,
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
    },
    driver: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
    },
    createdAt: {
        type: Date,
        default: Date.now
    },
});

module.exports = mongoose.model('Feedback', FeedbackSchema);