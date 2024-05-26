import { User } from "./User.model";

export class FeedbackModel {
    feedback: String = '';
    rating: number = 0;
    user: User = new User();
    driver: User = new User();
    createdAt: any;
}