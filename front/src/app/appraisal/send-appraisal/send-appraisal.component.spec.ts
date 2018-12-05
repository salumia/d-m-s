import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SendAppraisalComponent } from './send-appraisal.component';

describe('SendAppraisalComponent', () => {
  let component: SendAppraisalComponent;
  let fixture: ComponentFixture<SendAppraisalComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SendAppraisalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SendAppraisalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
