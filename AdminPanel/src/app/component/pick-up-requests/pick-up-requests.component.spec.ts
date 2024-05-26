import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PickUpRequestsComponent } from './pick-up-requests.component';

describe('PickUpRequestsComponent', () => {
  let component: PickUpRequestsComponent;
  let fixture: ComponentFixture<PickUpRequestsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PickUpRequestsComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PickUpRequestsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
