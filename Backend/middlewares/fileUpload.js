const multer = require('multer');


const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        file.fieldname === 'profile_pic' ? cb(null, './uploads/profile_pic') :
            file.fieldname === 'vehicle_pic' ? cb(null, './uploads/vehicle_pic') :
                file.fieldname === 'driving_license' ? cb(null, './uploads/driving_license') :
                    file.fieldname === 'nID' ? cb(null, './uploads/nID') :
                        file.fieldname === 'vehicle_registration' ? cb(null, './uploads/vehicle_registration') :
                            cb(null, './uploads');
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + file.originalname);
    }
});
const upload_multer = multer({ storage: storage });

module.exports = upload_multer;

