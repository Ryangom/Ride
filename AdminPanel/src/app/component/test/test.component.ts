import { Component } from '@angular/core';
import { ApplicationInfo } from 'src/app/model/ApplicationInfo.model';
import { AdminService } from 'src/app/service/admin.service';

@Component({
  selector: 'app-test',
  templateUrl: './test.component.html',
  styleUrls: ['./test.component.css']
})
export class TestComponent {

  adminService: AdminService;
  applicationInfo: ApplicationInfo = new ApplicationInfo();
  constructor(adminService: AdminService) {
    this.adminService = adminService;
  }


  ngOnInit(): void {
    this.adminService.getApplicationInfo().subscribe((data) => {
      this.applicationInfo = data.data;

    })


  }


}
