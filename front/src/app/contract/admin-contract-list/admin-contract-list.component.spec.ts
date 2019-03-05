import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AdminContractListComponent } from './admin-contract-list.component';

describe('AdminContractListComponent', () => {
  let component: AdminContractListComponent;
  let fixture: ComponentFixture<AdminContractListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AdminContractListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdminContractListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
