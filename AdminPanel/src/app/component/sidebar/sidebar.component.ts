import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AdminService } from 'src/app/service/admin.service';

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.css']
})
export class SidebarComponent {
  pulse: boolean = false;
  adminService: AdminService;
  constructor(private router: Router, adminService: AdminService) {
    this.adminService = adminService;
  }

  ngOnInit(): void {



    setInterval(() => {
      this.adminService.adminGetsEmergency().subscribe((data) => {
        if (data['data'][0]['status'] == 'onGoing') {
          this.pulse = true;
        }
      });
    }, 10000);
  }


  logout() {
    localStorage.removeItem("token");
    this.router.navigate(['/']);
  }
}
