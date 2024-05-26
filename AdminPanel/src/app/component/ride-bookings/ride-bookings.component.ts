import { Component } from '@angular/core';
import { RentCar } from 'src/app/model/RentCar.model';
import { AdminService } from 'src/app/service/admin.service';

@Component({
  selector: 'app-ride-bookings',
  templateUrl: './ride-bookings.component.html',
  styleUrls: ['./ride-bookings.component.css']
})
export class RideBookingsComponent {

  adminService: AdminService;
  bookings: RentCar[] = [];

  constructor(adminService: AdminService) {
    this.adminService = adminService;
  }

  ngOnInit(): void {
    this.adminService.adminGetAllBookings().subscribe((result) => {
      this.bookings = result['data'];

    });
  }

}
