import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AdminService } from 'src/app/service/admin.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})


export class LoginComponent {

  mobileNumber: string = '';
  password: string = '';
  message: string = '';

  adminService: AdminService;

  constructor(adminService: AdminService, private router: Router) {
    this.adminService = adminService;
  }

  ngOnInit(): void {
    if (this.adminService.isLoggedin()) {
      this.router.navigate(['/home']);
    }
  }

  login() {

    let user = {
      mobileNumber: this.mobileNumber,
      password: this.password,
      role: 'admin'
    }
    // add validation
    if (this.mobileNumber == '' || this.password == '') {
      this.message = "Please enter mobile number and password";
    }
    else {
      this.adminService.authenticateAdmin(user).subscribe(response => {
        if (response.status == 'success') {
          localStorage.setItem("token", response.token);
          this.router.navigate(['/home']);

        }

      }, error => {
        console.log(error.error.message);
        this.message = error.error.message;
      });
    }


  }
}
