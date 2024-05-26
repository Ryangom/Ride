import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { NgxPaginationModule } from 'ngx-pagination';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AddDriverComponent } from './component/add-driver/add-driver.component';
import { ComplianceComponent } from './component/compliance/compliance.component';
import { CustomersComponent } from './component/customers/customers.component';
import { DriversComponent } from './component/drivers/drivers.component';
import { HeaderComponent } from './component/header/header.component';
import { LoginComponent } from './component/login/login.component';
import { MainScreenComponent } from './component/main-screen/main-screen.component';
import { ReportComponent } from './component/report/report.component';
import { RideBookingsComponent } from './component/ride-bookings/ride-bookings.component';
import { SettingsComponent } from './component/settings/settings.component';
import { SidebarComponent } from './component/sidebar/sidebar.component';
import { TestComponent } from './component/test/test.component';
import { TripsComponent } from './component/trips/trips.component';
import { VehiclesComponent } from './component/vehicles/vehicles.component';
import { AddVehicleComponent } from './component/add-vehicle/add-vehicle.component';
import { PickUpRequestsComponent } from './component/pick-up-requests/pick-up-requests.component';
import { EmergencyComponent } from './component/emergency/emergency.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HeaderComponent,
    SidebarComponent,
    TestComponent,
    CustomersComponent,
    DriversComponent,
    RideBookingsComponent,
    TripsComponent,
    ComplianceComponent,
    VehiclesComponent,
    MainScreenComponent,
    ReportComponent,
    AddDriverComponent,
    SettingsComponent,
    AddVehicleComponent,
    PickUpRequestsComponent,
    EmergencyComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    NgxPaginationModule

  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
