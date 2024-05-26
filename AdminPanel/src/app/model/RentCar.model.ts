import { User } from "./User.model";

export class RentCar {
    _id: string = '';
    bided: [] = [];
    createdAt = '';
    customer: User = new User();
    destinationEn: String = '';
    destinationGeoCode: any;
    distance: string = '';
    driver: User = new User();
    eta: string = '';
    pickupLocationEn: string = '';
    pickupLocationGeoCode: any;
    scheduleTime: string = '';
    status: string = '';
    totalPrice: string = '';
}