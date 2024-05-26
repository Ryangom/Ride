const mongoose = require('mongoose');



//removing the deprecation warning
mongoose.set('strictQuery', false);


// Configuring the Mongo database
mongoose.connect('mongodb://127.0.0.1:27017/RideApp',
    {
        useNewUrlParser: true,
        useUnifiedTopology: true
    }).then(() => {
        console.log('DB connected');
    }).catch((err) => {
        console.log('DB connection error: ', err);
    });



