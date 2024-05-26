import { Component } from '@angular/core';
import { VehicleModel } from 'src/app/model/Vehicle.model';
import { AdminService } from 'src/app/service/admin.service';

@Component({
  selector: 'app-vehicles',
  templateUrl: './vehicles.component.html',
  styleUrls: ['./vehicles.component.css']
})

export class VehiclesComponent {
  vehiclesData: VehicleModel[] = [];
  page: any;

  adminService: AdminService;
  constructor(adminService: AdminService) {
    this.adminService = adminService;
  }

  ngOnInit() {
    this.adminService.adminGetsAllVehiclesData().subscribe((result) => {
      this.vehiclesData = result['data'];
    });
  }
}
