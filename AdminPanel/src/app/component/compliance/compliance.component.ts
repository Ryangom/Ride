import { Component } from '@angular/core';
import { Complaint } from 'src/app/model/complaint.model';
import { AdminService } from 'src/app/service/admin.service';

@Component({
  selector: 'app-compliance',
  templateUrl: './compliance.component.html',
  styleUrls: ['./compliance.component.css']
})
export class ComplianceComponent {
  page: any;
  adminService: AdminService;
  complaint: Complaint[] = [];
  constructor(adminService: AdminService) {
    this.adminService = adminService;
  }

  ngOnInit() {
    this.adminService.adminGetsAllComplaint().subscribe((result) => {
      this.complaint = result['data'];
    });
  }


}
