import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/model/User.model';
import { VehicleModel } from 'src/app/model/Vehicle.model';
import { AdminService } from 'src/app/service/admin.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-add-driver',
  templateUrl: './add-driver.component.html',
  styleUrls: ['./add-driver.component.css']
})
export class AddDriverComponent {
  addUserModel: User = new User();
  cpasswords: string = '';
  profileImage: any;
  adminService: AdminService;
  vehicleModel: VehicleModel = new VehicleModel();

  drivingLicense: File = new File([], '');
  vehicleRegistration: File = new File([], '');
  nid: File = new File([], '');
  vehicalImage: File = new File([], '');


  constructor(adminService: AdminService, private router: Router) {
    this.adminService = adminService;
  }

  ngOnInit(): void {

  }
  addDriver() {
    this.addUserModel.role = 'driver';
    this.addUserModel.vehicle = this.vehicleModel;

    this.adminService.adminAddDriver(
      this.addUserModel,
      this.drivingLicense,
      this.nid,
      this.vehicalImage,
      this.vehicleRegistration
    ).subscribe((data: any) => {
      if (data['status'] == 'success') {
        this.router.navigateByUrl('/home/(admin:drivers)');
        Swal.fire({
          icon: 'success',
          title: 'Driver Added Successfully',
          showConfirmButton: false,
          timer: 1500
        })
      }
      else {
        Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: 'Something went wrong!',
        })
      }

    })


  }
  onFileUp(event: any) {
    switch (event.target.name) {
      case 'drivingLicense':
        this.drivingLicense = event.target.files[0];
        break;
      case 'vehicleRegistration':
        this.vehicleRegistration = event.target.files[0];
        break;
      case 'nid':
        this.nid = event.target.files[0];
        break;
      case 'vehicalImage':
        this.vehicalImage = event.target.files[0];
        break;
    }
  }
}
