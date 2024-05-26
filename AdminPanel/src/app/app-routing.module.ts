import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AddDriverComponent } from './component/add-driver/add-driver.component';
import { AddVehicleComponent } from './component/add-vehicle/add-vehicle.component';
import { ComplianceComponent } from './component/compliance/compliance.component';
import { CustomersComponent } from './component/customers/customers.component';
import { DriversComponent } from './component/drivers/drivers.component';
import { LoginComponent } from './component/login/login.component';
import { MainScreenComponent } from './component/main-screen/main-screen.component';
import { ReportComponent } from './component/report/report.component';
import { RideBookingsComponent } from './component/ride-bookings/ride-bookings.component';
import { SettingsComponent } from './component/settings/settings.component';
import { TestComponent } from './component/test/test.component';
import { TripsComponent } from './component/trips/trips.component';
import { VehiclesComponent } from './component/vehicles/vehicles.component';
import { EmergencyComponent } from './component/emergency/emergency.component';
// canActivate: [AuthGuard]
const routes: Routes = [
  { path: '', component: LoginComponent },
  {
    path: 'home', component: MainScreenComponent, children: [
      { path: '', component: TestComponent, outlet: 'admin' },
      { path: 'customers', component: CustomersComponent, outlet: 'admin' },
      { path: 'drivers', component: DriversComponent, outlet: 'admin' },
      { path: 'addDriver', component: AddDriverComponent, outlet: 'admin' },
      { path: 'addVehicle', component: AddVehicleComponent, outlet: 'admin' },
      { path: 'bookings', component: RideBookingsComponent, outlet: 'admin' },
      { path: 'trips', component: TripsComponent, outlet: 'admin' },
      { path: 'compliance', component: ComplianceComponent, outlet: 'admin' },
      { path: 'vehicles', component: VehiclesComponent, outlet: 'admin' },
      { path: 'report', component: ReportComponent, outlet: 'admin' },
      { path: 'settings', component: SettingsComponent, outlet: 'admin' },
      { path: 'emergency', component: EmergencyComponent, outlet: 'admin' },
    ]
  },


];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
