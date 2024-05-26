import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RideBookingsComponent } from './ride-bookings.component';

describe('RideBookingsComponent', () => {
  let component: RideBookingsComponent;
  let fixture: ComponentFixture<RideBookingsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RideBookingsComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RideBookingsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
