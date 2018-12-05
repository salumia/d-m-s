import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { Message } from 'primeng/components/common/api';
import { MessageService } from 'primeng/components/common/messageservice';
import { HttpErrorResponse } from '@angular/common/http';
import { AppraisalService } from '../appraisal.service';
import { Appraisal } from '../appraisal';
import { ConfirmationService } from 'primeng/api';
import { AuthService } from '../../auth/auth.service';
import { User } from '../../user/user';

@Component({
  selector: 'app-send-appraisal',
  templateUrl: './send-appraisal.component.html',
  styleUrls: ['./send-appraisal.component.css']
})
export class SendAppraisalComponent implements OnInit {
	id: number;
    users: any;
    appraisal: any = {};
	responsibilities: any = [];
    newResponsibility: any = {};
    editResponsibility: any = {};
    msgs = [];
    Appraisalform: FormGroup;
    Responsibilityform: FormGroup;
    editResponsibilityform: FormGroup;
	
	minDate:Date = new Date();
	enableToDate:boolean = false;
	showModal:boolean = false;
	showEditModal:boolean = false;
	
	loggedInUser: User;
	
	constructor(private confirmService: ConfirmationService, aroute: ActivatedRoute, private router: Router, private fb: FormBuilder, private messageService: MessageService, private appraisalService: AppraisalService, private authService: AuthService) {
		aroute.params.subscribe(params => {
		  this.id = params['id'];	  
		});
	}

	ngOnInit() {
		this.loggedInUser = this.authService.getAuth();
		this.loadUsers();
		this.Appraisalform = this.fb.group({
			'from_date': new FormControl('', Validators.required),
			'to_date': new FormControl('', Validators.required),   
			'user_id': new FormControl('', Validators.required),
			'reviewer_id': new FormControl('', Validators.required)  
		});
		
		this.Responsibilityform = this.fb.group({
			'comment': new FormControl('', Validators.required)
		});
		
		this.editResponsibilityform = this.fb.group({
            'id': new FormControl(''),
			'comment': new FormControl('', Validators.required)
		});
		if( this.id > 0 ){
			this.loadAppraisal();
		}
	}
  
	loadUsers() {
		this.appraisalService.getUsersList(this.loggedInUser.id).subscribe(res => {
		  this.users = res;
		  this.users.unshift({label: 'Select', value: ''});
		});
	}	
	
	loadAppraisal() {
		console.log(this.appraisal);
		this.appraisalService.getAppraisal(this.id).subscribe(res => {
			this.appraisal = res;
			this.appraisal.from_date = new Date(Date.parse(this.appraisal.from_date));
			this.appraisal.to_date = new Date(Date.parse(this.appraisal.to_date));
			this.responsibilities = this.appraisal.get_key_responsibility_data;
			console.log(this.appraisal);
		});
	}
	
	sendForm(data) {	  
		this.appraisalService.sendAppraisalForm(this.id, this.appraisal).subscribe(res => {			
			if(this.id > 0){				
				this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Appraisal updated successfully'});
			}else{
				if(res.appraisal.id > 0){
					this.id = res.appraisal.id;
					this.saveResponsibility();
				}
				this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Appraisal sent successfully'});
			}
			setTimeout(() => {
				this.router.navigate(['appraisal/list']);
			}, 2000);
		});
	}
	
	onSelectFromDate(date){
	  console.log('onSelectFromDate');
	  this.enableToDate = true;
	  this.minDate = this.appraisal.from_date;
	  this.appraisal.to_date = this.appraisal.from_date;	  
	}
	
	addResponsibility(value: any) {  
        if(typeof this.id != 'undefined'){
            this.newResponsibility.appraisal_id = this.id;
            /****** Call Add Contact Service ******/
            this.appraisalService.saveResponsibility([this.newResponsibility]).subscribe(
                response => {
                    if (response instanceof HttpErrorResponse) {
                        this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error:', detail: response.error.message});
                    } else {
                        this.responsibilities.push(this.newResponsibility);
                        this.newResponsibility = {};
                        this.Responsibilityform.reset();
                        this.showModal = false;
                        this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Key Responsibility added successfully'});
                    }
                },
                error => {
                    this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error:', detail: error.message});
            });
            /**************************************/
        } else {
            this.responsibilities.push(this.newResponsibility);
            this.newResponsibility = {};
            this.Responsibilityform.reset();
            this.showModal = false;
        }          
    }
	
	deleteForm(resp) {
        this.confirmService.confirm({
            message: 'Are you sure that you want to perform this action?',
            key: 'delete',
            accept: () => {               
                    if(typeof this.id != 'undefined'){
                        /****** Call Delete Responsibility Service ******/
                       this.appraisalService.deleteResponsibility(resp.id).subscribe(
                          response => {
                            if (response instanceof HttpErrorResponse) {
                              this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error:', detail: response.error.message});
                            } else {
                              this.responsibilities.splice(resp, 1);
                              this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'deleted successfully'});
                            }
                          },
                          error => {
                            this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error:', detail: error.message});
                          });
                        /**************************************/                        
                    } else {
                        this.responsibilities.splice(resp, 1);
                    } 
            }
        });        
    }
	
	showEditForm(offset) {
        this.showEditModal = true;
        this.editResponsibility = this.responsibilities[offset];
    }
	
	onHideAddForm() {
        this.msgs = [];
        this.newResponsibility = {};
        this.Responsibilityform.reset();
    }

    onHideEditForm() {
        this.msgs = [];
        this.editResponsibility = {};
        this.editResponsibilityform.reset();
    } 
	
	updateResponsibility(value: any) {
        if(typeof this.id != 'undefined'){        
            /****** Call Update Responsibility Service ******/
            this.appraisalService.saveKeyResponsibility([this.editResponsibility]).subscribe(
                response => {
                    if (response instanceof HttpErrorResponse) {
                        this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error:', detail: response.error.message});
                    } else {
                        this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Responsibility updated successfully'});
                        this.editResponsibility = {};
                        this.editResponsibilityform.reset();
                        this.showEditModal = false;
                    }
                },
                error => {
                    this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error:', detail: error.message});
                });
            /**************************************/           
        } else {
            this.editResponsibility = {};
            this.editResponsibilityform.reset();
            this.showEditModal = false;
        }          
    }

	saveResponsibility(){
		if(this.id > 0){
			this.responsibilities.forEach((obj, index) => {
                obj.appraisal_id = this.id;
            });
			this.appraisalService.saveResponsibility(this.responsibilities).subscribe(
                response => {
                    if (response instanceof HttpErrorResponse) {
                        return false;
                    } else {
                        return true;
                    }
                },
                error => {
                return false;
            });
		}
	}
}