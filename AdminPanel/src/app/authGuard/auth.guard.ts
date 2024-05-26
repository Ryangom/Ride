import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { AdminService } from '../service/admin.service';

@Injectable({
  providedIn: 'root'
})



export class AuthGuard implements CanActivate {

  constructor(private auth: AdminService, private router: Router) { }
  canActivate() {

    if (this.auth.isLoggedin()) {
      return true;
    }
    else {
      this.router.navigate(['/']);
      return false;
    }
  }

}
