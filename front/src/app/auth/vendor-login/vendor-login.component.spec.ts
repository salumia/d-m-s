import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VendorLoginComponent } from './vendor-login.component';

describe('LoginComponent', () => {
  let component: VendorLoginComponent;
  let fixture: ComponentFixture<VendorLoginComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VendorLoginComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VendorLoginComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
