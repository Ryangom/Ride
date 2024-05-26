import { Component } from '@angular/core';
import { User } from 'src/app/model/User.model';
import { AdminService } from 'src/app/service/admin.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-customers',
  templateUrl: './customers.component.html',
  styleUrls: ['./customers.component.css']
})
export class CustomersComponent {

  adminService: AdminService;

  modalOpen: boolean = false;
  userAddModalOpen: boolean = false;
  page: any;
  userData: User[] = [];
  selectedUser: User = new User();
  addUserModel: User = new User();
  profileImage: any;
  cpasswords: string = '';


  constructor(adminService: AdminService) {
    this.adminService = adminService;
  }


  ngOnInit(): void {
    this.adminService.getsAllUsers().subscribe((result) => {
      this.userData = result.data;

    });
  }

  userAddModal() {
    this.userAddModalOpen = true;
  }

  selectedUserId: any;
  editModelOpen(data: any) {
    this.selectedUserId = data._id;
    this.selectedUser = data;
    this.modalOpen = true;
  }
  ModalClose() {
    this.userAddModalOpen = false;
    this.modalOpen = false;
  }
  onFileUp(event: any) {
    this.profileImage = event.target.files[0];
  }

  updateUser() {

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
        this.adminService.updateUserInfo(this.selectedUser, this.profileImage).subscribe((result) => {
          Swal.fire(
            'Updated!',
            'User has been updated.',
            'success'
          )
          this.ngOnInit();
          this.modalOpen = false;
        });
      }

    }
    )


  }

  addUser() {
    this.addUserModel.role = 'user';
    this.addUserModel.status = 'active';




    if (this.profileImage) {
      // if file found
      this.adminService.createUserAccount(JSON.stringify(this.addUserModel), this.profileImage,).subscribe((result) => {
        if (result.status == 'success') {
          this.ngOnInit();
          Swal.fire(
            'Added!',
            'User has been added.',
            'success'
          )
          this.userAddModalOpen = false;
        }
        else {
          Swal.fire(
            'Error!',
            'User has not been added.',
            'error'
          )
        }
      });
    }
    else {
      // if file not found
      this.adminService.adminAddUserWithoutFile(this.addUserModel).subscribe((result) => {
        if (result.status == 'success') {
          this.userData.push(this.addUserModel);
          Swal.fire(
            'Added!',
            'User has been added.',
            'success'
          )
          this.userAddModalOpen = false;
        }
        else {
          Swal.fire(
            'Error!',
            'User has not been added.',
            'error'
          )
        }
      }
      );

    }


  }


  deleteUser(data: any) {
    Swal.fire({
      title: 'Are you sure?',
      text: 'You want to delete this user!',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
      if (result.isConfirmed) {
        this.adminService.adminDeleteUser(data._id).subscribe((result) => {
          if (result.status == 'success') {

            this.userData.forEach((item, index) => {
              if (item === data) this.userData.splice(index, 1);
            });
            Swal.fire(
              'Deleted!',
              'User has been deleted.',
              'success'
            )
          }
          else if (result.status == 'error') {
            Swal.fire(
              'Error!',
              'User has not been deleted.',
              'error'
            )

          }
        });
      }
    }
    )
  }



}
