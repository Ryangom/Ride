import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../model/User.model';
import { AdminShare } from '../model/adminShare.model';

const ipAdress = environment.ip;

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  httpClient: HttpClient;

  constructor(httpClient: HttpClient) {
    this.httpClient = httpClient;
  }

  isLoggedin() {
    return localStorage.getItem("token");
  }


  authenticateAdmin(user: any): Observable<any> {
    return this.httpClient.post(ipAdress + '/auth/login', user);
  }



  getsAllUsers(): Observable<any> {
    const token = localStorage.getItem("token")
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.get(ipAdress + '/admin/adminGetsAllUser/user', { headers: headers });
  }
  getsAllDrivers(): Observable<any> {
    const token = localStorage.getItem("token")
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.get(ipAdress + '/admin/adminGetsAllUser/driver', { headers: headers });
  }

  getApplicationInfo(): Observable<any> {
    const token = localStorage.getItem("token")
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.get(ipAdress + '/admin/adminGetsBasicInfos', { headers: headers });
  }

  adminAddUserWithoutFile(user: User): Observable<any> {
    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.post(ipAdress + '/auth/register', user, { headers: headers });

  }

  adminAddDriver(user: User, drivingLicense: File, nid: File, vehicalImage: File, vehicle_registration: File): Observable<any> {
    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    let formData = new FormData();
    formData.append("user", JSON.stringify(user));
    formData.append("driving_license", drivingLicense);
    formData.append("nID", nid);
    formData.append("vehicle_pic", vehicalImage);
    formData.append("vehicle_registration", vehicle_registration);
    return this.httpClient.post(ipAdress + '/auth/driverRegister', formData, { headers: headers });

  }


  updateUserInfo(user: User, file: File): Observable<any> {
    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });

    let formData = new FormData();
    formData.append("user", JSON.stringify(user));
    formData.append("profile_pic", file);
    return this.httpClient.post(ipAdress + '/user/updateUserProfile', formData, { headers: headers });

  }

  adminUpdateUserImage(image: File, id: string): Observable<any> {

    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    let formData: FormData = new FormData();
    formData.append("profile_pic", image);
    return this.httpClient.post(ipAdress + '/user/uploadFile/' + id + '', formData, { headers: headers });
  }


  adminDeleteUser(id: string): Observable<any> {
    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.post(ipAdress + '/admin/adminDeleteUser/' + id, { headers: headers });
  }


  createUserAccount(user: string, image: File): Observable<any> {
    let token = localStorage.getItem("token")
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    let formData: FormData = new FormData();
    formData.append("user", user);
    formData.append("profile_pic", image);

    return this.httpClient.post(ipAdress + '/admin/adminAddUser', formData, { headers: headers });
  }

  adminGetsAllComplaint(): Observable<any> {

    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.get(ipAdress + '/admin/adminGetAllComplain', { headers: headers });
  }

  adminGetsAllVehiclesData(): Observable<any> {

    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.get(ipAdress + '/admin/getAllVehicle', { headers: headers });
  }

  adminDownoadUserReport(type: string): Observable<any> {
    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.get(ipAdress + '/admin/adminDownoadUserReport/' + type, { headers: headers });
  }



  adminGetAllBookings(): Observable<any> {
    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });

    return this.httpClient.get(ipAdress + '/admin/adminGetAllBookings', { headers: headers });
  }




  adminGetsAdminShare(): Observable<any> {

    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.get(ipAdress + '/admin/adminGetsAdminShare', { headers: headers });
  }
  adminUpdateAdminShare(adminShare: AdminShare): Observable<any> {

    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.post(ipAdress + '/admin/adminUpdateAdminShare', adminShare, { headers: headers });
  }


  adminGetsEmergency(): Observable<any> {

    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });
    return this.httpClient.get(ipAdress + '/admin/adminGetsEmergency', { headers: headers });
  }


  adminGetsEmergencyUpdate(body: any): Observable<any> {

    const token = localStorage.getItem("token");
    const headers = new HttpHeaders({
      authorization: 'Bearer ' + token
    });

    return this.httpClient.post(ipAdress + '/admin/adminGetsEmergencyUpdate', body, { headers: headers });
  }







}
