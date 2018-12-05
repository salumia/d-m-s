import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { Message } from 'primeng/components/common/api';
import { MessageService } from 'primeng/components/common/messageservice';
import { HttpErrorResponse } from '@angular/common/http';
import { AppraisalService } from '../appraisal.service';
import { Appraisal } from '../appraisal';
import { AuthService } from '../../auth/auth.service';
import { User } from '../../user/user';
import {ConfirmationService} from 'primeng/api';


@Component({
  selector: 'app-appraisal-form',
  templateUrl: './appraisal-form.component.html',
  styleUrls: ['./appraisal-form.component.css']
})
export class AppraisalFormComponent implements OnInit {

	loggedInUser: User;
	activeStep:string = 'step1';
	id: number;
	feedbackAction: string = 'update';
    appraisal: any = {};
    appraisalPoints: any;
    appraisalKeyResponsibility: any;
    appraisalFeedback: any = [];
    msgs = [];
    Appraisalform: FormGroup;
	saveButtonText:string = '';
	successMsg:string = '';
	
	staffFields:boolean = false;
	reviewerFields:boolean = false;
	appraiseeFields:boolean = false;
	commonFields:boolean = false;
	  
	constructor(aroute: ActivatedRoute, private router: Router, private fb: FormBuilder, private messageService: MessageService, private appraisalService: AppraisalService, private auth: AuthService, private confirmationService: ConfirmationService) { 
		aroute.params.subscribe(params => {
		  this.id = params['id'];	  
		});
	}
	
	ngOnInit() {
		this.loggedInUser = this.auth.getAuth();
		console.log(this.loggedInUser);
		if(this.id > 0){
			this.loadAppraisalForm();
		} else {
			this.getActiveAppraisal();
		}
		this.loadAppraisalPoints();

	}
  
	getActiveAppraisal() {
		this.appraisalService.getActiveAppraisal(this.loggedInUser.id).subscribe(res => {
			if(res.data != null){
				this.id = res.data.id;
				this.loadAppraisalForm();
			}  			
        });
	}
	
	setActiveFields() {	
	console.log(this.appraisal);
		if(this.appraisal.user_id == this.loggedInUser.id && this.appraisal.status == "Pending" ){
			this.appraiseeFields = true;
			this.saveButtonText = 'Send to Reviewer';
		} else if(this.appraisal.reviewer_id == this.loggedInUser.id && this.appraisal.status == "Reviewing"){
			this.reviewerFields = true;
			this.saveButtonText = 'Send to HOD';
		} else if(this.appraisal.department == this.loggedInUser.department && this.loggedInUser.designation == 'hod' && this.appraisal.status == "Completed" && this.appraisal.stage == 3){
			this.reviewerFields = true;
			this.saveButtonText = 'Send to HR';
		} else if(this.appraisal.user_id != this.loggedInUser.id && this.loggedInUser.department == 1 && this.appraisal.stage > 3){
			this.staffFields = true;
			this.saveButtonText = 'Save & Complete';
		} else {
			this.saveButtonText = '';
		}
		
		
		console.log(this.appraiseeFields);
		console.log(this.reviewerFields);
		console.log(this.staffFields);
	}
	
	loadAppraisalForm() {
		if(this.id > 0){
			this.appraisalService.getAppraisalForm(this.id).subscribe(res => {
				this.appraisal = res;				
				this.appraisalFeedback = this.appraisal.get_feed_back_data;			
				this.appraisalKeyResponsibility = this.appraisal.get_key_responsibility_data;
				this.setActiveFields();				
				console.log(this.appraisal);
				console.log(this.appraisalKeyResponsibility);
			});
		}
	}
		
	loadAppraisalPoints() {
		this.appraisalService.getAllAppraisalPoints().subscribe(res => {
			this.appraisalPoints = res;
			console.log(this.appraisalPoints);
		});
	}

	prevStep(step){		
		this.activeStep  =  'step'+step;	
	}
		
	nextStep(step, section){
		
		this.activeStep  =  'step'+step;
		console.log(this.appraisalFeedback);
		
		if((this.loggedInUser.id == this.appraisal.user_id) && this.appraisal.status == "Pending")
		{ //appraisee			
			if(step == 4){
				this.saveKeyResponsibility();			
			}
			
			if(step > 3){
				this.saveForm(section);		
			}		
		} else if((this.loggedInUser.id == this.appraisal.reviewer_id) && this.appraisal.status == "Reviewing"){
			//Reviewer
			if(step == 4){
				this.saveKeyResponsibility();			
			}
			
			if(step > 3){
				this.saveForm(section);		
			}			
		} else if(this.appraisal.department == this.loggedInUser.department && this.loggedInUser.designation == 'hod' && this.appraisal.status == "Completed" && this.appraisal.stage == 3){
			//Reviewer
			if(step == 4){
				this.saveKeyResponsibility();			
			}
			
			if(step > 3){
				this.saveForm(section);		
			}			
		} else if(this.staffFields && this.appraisal.status == "Completed"){
			//HR/Admin
			if(step == 4){
				this.saveKeyResponsibility();			
			}
			
			if(step > 3){
				this.saveForm(section);		
			}			
		}
	}	
	
	
	saveAppraisalForm(){
		this.confirmationService.confirm({
            message: 'Are you sure that you want to proceed?',
            header: 'Confirmation',
            accept: () => {
				this.saveForm('P7');		
				if(this.appraisal.status == "Pending"){
					this.updateAppraisalStatus('Reviewing',2);
				} else if(this.appraisal.status == "Reviewing"){
					this.updateAppraisalStatus('Completed',3);
				} else if(this.appraisal.status == "Completed" && this.appraisal.stage == 3){
					this.updateAppraisalStatus('Completed',4);
				} else if(this.appraisal.status == "Completed" && this.appraisal.stage == 4){
					this.updateAppraisalStatus('Completed',5);
				}
            },
            reject: () => {
            }
        });		
	}
		
	updateAppraisalStatus(status,stage){	
		this.appraisal.status = status;
		this.appraisal.stage = stage;
		this.saveButtonText = '';
		if(stage == 2){
			this.successMsg = "Form sent to reviewer successfully";
		} else if(stage == 3){
			this.successMsg = "Form sent to HOD successfully";
		} else if(stage == 4){
			this.successMsg = "Form sent to HR successfully";
		} else {
			this.successMsg = "Congratulations!!.. Appraisal Done.";
		}
		this.appraisalService.sendAppraisalForm(this.id, this.appraisal).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: this.successMsg});
		});
	}
	
	saveForm(section){
		console.log(section);	
		console.log(this.appraisalFeedback.filter(item => item.section == section));	
		this.appraisalService.saveFeedback(this.appraisalFeedback.filter(item => item.section == section), this.appraisal.id, this.feedbackAction).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Feedback saved successfully'});
		});
	}	
	
	saveKeyResponsibility(){
		console.log(this.appraisalKeyResponsibility);		
		this.appraisalService.saveKeyResponsibility(this.appraisalKeyResponsibility).subscribe(res => {
				//this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Feedback saved successfully'});
			});
	}
	
	handleRate(event, index) {
        this.appraisalFeedback[index].rating = event.value;
    }
	
	handleResponsibilityRate(event, index) {
        this.appraisalKeyResponsibility[index].rating = event.value;
    }
	
	/********************/
	/* 	
	Stages
	1 / Pending
	2 / Reviewing By Reviewer
	3 / Reviewing By HOD
	4 / Reviewing By HR/Admin
	5 / DONE 
	*/

}
