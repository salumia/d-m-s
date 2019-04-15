import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AccessContractComponent } from './access-contract.component';

describe('AccessContractComponent', () => {
  let component: AccessContractComponent;
  let fixture: ComponentFixture<AccessContractComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AccessContractComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AccessContractComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
