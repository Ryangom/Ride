import { User } from "./User.model";

export class VehicleModel {
    name: String = '';
    plateNumber: String = '';
    color: string = '';
    image: string = '';
    vehicleOwner: User = new User()
    createdAt: any;
}