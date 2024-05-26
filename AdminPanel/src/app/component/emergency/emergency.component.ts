import { Component } from '@angular/core';
import { Emergency } from 'src/app/model/emergency.model';
import { AdminService } from 'src/app/service/admin.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-emergency',
  templateUrl: './emergency.component.html',
  styleUrls: ['./emergency.component.css']
})
export class EmergencyComponent {

  emergencyData: Emergency[] = [];
  adminService: AdminService;

  constructor(adminService: AdminService) {
    this.adminService = adminService;
  }

  ngOnInit(): void {
    this.getEmergencyData();
  }



  getEmergencyData() {
    this.adminService.adminGetsEmergency().subscribe((data) => {
      this.emergencyData = data['data'];

    });
  }

  action(data: Emergency, status: string) {
    data.status = status;
    this.adminService.adminGetsEmergencyUpdate(data).subscribe((data) => {
      if (data['status'] == 'success') {
        Swal.fire({
          icon: 'success',
          title: 'Success',
          text: 'Emergency data updated successfully',
        });
        //wait 1 second before reload
        setTimeout(function () {
          window.location.reload();
        }, 1500);


      }

    });
  }

}
// https://maps.google.com/?q=[23.649247039514897, 90.16545038688538]