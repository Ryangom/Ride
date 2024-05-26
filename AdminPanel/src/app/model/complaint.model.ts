import { User } from "./User.model";

export class Complaint {
    complain: string = "";
    name: string = "";
    subject: string = "";
    user: User = new User();

}