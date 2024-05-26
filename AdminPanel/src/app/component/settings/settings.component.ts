import { Component } from '@angular/core';
import { AdminShare } from 'src/app/model/adminShare.model';
import { AdminService } from 'src/app/service/admin.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html',
  styleUrls: ['./settings.component.css']
})
export class SettingsComponent {

  adminShare: AdminShare = new AdminShare();
  adminService: AdminService;
  constructor(adminService: AdminService) {
    this.adminService = adminService;
  }
  ngOnInit(): void {
    this.adminService.adminGetsAdminShare().subscribe((data) => {
      this.adminShare = data['data'];
    });
  }
  update() {
    this.adminService.adminUpdateAdminShare(this.adminShare).subscribe((data) => {
      if (data['status'] == 'success') {
        Swal.fire({
          icon: 'success',
          title: 'Success',
          text: 'Updated Successfully',
        });
        this.ngOnInit();
      }

    });

  }



}
