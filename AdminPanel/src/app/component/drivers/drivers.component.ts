import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/model/User.model';
import { AdminService } from 'src/app/service/admin.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-drivers',
  templateUrl: './drivers.component.html',
  styleUrls: ['./drivers.component.css']
})
export class DriversComponent {
  adminService: AdminService;

  modalOpen: boolean = false;
  userAddModalOpen: boolean = false;
  page: any;
  driverData: User[] = [];
  selectedUser: User = new User();
  addUserModel: User = new User();
  profileImage: any;
  cpasswords: string = '';


  constructor(adminService: AdminService, private router: Router) {
    this.adminService = adminService;
  }


  ngOnInit(): void {
    this.adminService.getsAllDrivers().subscribe((result) => {
      this.driverData = result.data;


    });
  }
  selectedUserId: any;
  editModelOpen(data: any) {
    this.selectedUserId = data._id;
    this.selectedUser = data;
    this.modalOpen = true;
  }
  deleteUser(data: any) {

    this.adminService.adminDeleteUser(data._id).subscribe((result) => {
      if (result['status'] == 'success') {
        Swal.fire(
          'Deleted!',
          'Driver has been deleted.',
          'success'
        )
        this.ngOnInit();
      }

    });

  }
  addDriver() {
    // /admin/(admin:add_vendor/(add_vendor:store_info)
    this.router.navigateByUrl('/home/(admin:addDriver)');
  }


  onFileUp(event: any) {
    this.profileImage = event.target.files[0];
  }

  ModalClose() {
    this.userAddModalOpen = false;
    this.modalOpen = false;
  }

  updateUser() {
    var id = this.selectedUserId;
    if (this.profileImage) {
      Swal.fire({
        title: 'Are you sure?',
        text: 'You want to update this user!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, update it!'
      }).then((result) => {
        if (result.isConfirmed) {
          this.adminService.updateUserInfo(this.selectedUser, id).subscribe((result) => {

            Swal.fire(
              'Updated!',
              'Driver has been updated.',
              'success'
            )
            this.modalOpen = false;
          });

          this.adminService.adminUpdateUserImage(this.profileImage, id).subscribe((result) => {
            this.ngOnInit();
          });
        }

      }
      )
    }
    else {
      Swal.fire({
        title: 'Are you sure?',
        text: 'You want to update this Driver!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, update it!'
      }).then((result) => {
        if (result.isConfirmed) {
          this.adminService.updateUserInfo(this.selectedUser, id).subscribe((result) => {
            console.log(result);

            Swal.fire(
              'Updated!',
              'User has been updated.',
              'success'
            )
            this.modalOpen = false;
          });
          console.log('ok');
        }

      }
      )
    }

  }
}
