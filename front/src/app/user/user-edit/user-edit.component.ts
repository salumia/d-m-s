import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { UserService } from '../user.service';
import { User } from '../user';
import { Message, SelectItem } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { AuthService } from '../../auth/auth.service';
import { MessageService } from 'primeng/components/common/messageservice';
import {Location} from '@angular/common';

@Component({
  selector: 'app-user-edit',
  templateUrl: './user-edit.component.html',
  styleUrls: ['./user-edit.component.css']
})
export class UserEditComponent implements OnInit {
	@ViewChild('documentsChild') documentsChild;
	id: number;
	user: User = {} as User;
	roles: SelectItem[];
	departments: SelectItem[];
	designations: SelectItem[];
	msgs: Message[] = [];
	Userform: FormGroup;
	loadComponents: boolean = false;
	loggedInUser: any;
	enableDepartment:boolean = false;
	enableDesignation:boolean = false;
	disableFieldsFlag:boolean = true;
	loadSpinner: boolean = false;

  constructor(aroute: ActivatedRoute, private router: Router, private userService: UserService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location) {
    aroute.params.subscribe(params => {
      this.id = params['id'];
      if(this.id > 0){
		  this.loadSpinner = true;
	  }
    });
  }

  ngOnInit() {
	
	this.loggedInUser = this.auth.getAuth();
	
	console.log('User');
	console.log(this.loggedInUser.id);
	
	console.log(this.id);
	
	
	if((this.loggedInUser.id != this.id && this.loggedInUser.department == 1) || this.loggedInUser.role == 'admin'){
		this.disableFieldsFlag = false;  
	}

	
	this.Userform = this.fb.group({
			'first_name': new FormControl('', Validators.required),            
			'last_name': new FormControl('', Validators.required),            
			'father_name': new FormControl('', Validators.required),            
			'mother_name': new FormControl('', Validators.required),
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]),this.isEmailUnique.bind(this)),			
			'phone': new FormControl('', Validators.required),            
			'alt_phone': new FormControl(''),            
			'correspondence_address': new FormControl('', Validators.required),            
			'permanent_address': new FormControl('', Validators.required),            
			'password': new FormControl('')
		});
	 
	// Load Roles
    this.roles = [
      { label: '(select)', value: null },
      { label: 'Subscriber', value: 'superadmin' },
      { label: 'Disabled', value: 'disabled' }
    ];
	
	// Load Departments
    this.departments = [
      { label: '(select)', value: null },
      { label: 'HR', value: 1 },
      { label: 'Marketing & Software Development', value: 2 },
      { label: 'Finance', value: 3 }
    ];	
	
	// Load Designations
    this.designations = [
      { label: '(select)', value: null },
      { label: 'H.O.D', value: 'hod' }  
    ];
	  if(this.id > 0 ){
		this.loadUser();
		if(!this.disableFieldsFlag){
			this.enableDepartment = true;
			this.enableDesignation = true;
		}
	  }else{
		this.Userform.controls['password'].setValidators(Validators.required);
		this.disableFieldsFlag = false;
		this.enableDepartment = true;
	  }
  }
  
  loadUser() {
    // Load User
    this.userService.getUser(this.id).subscribe(res => {
      this.user = res;
	  this.loadComponents = true;
	  this.loadSpinner = false;
    });

  }
    isEmailUnique(control: FormControl) {
        const q = new Promise((resolve, reject) => {
            setTimeout(() => {
                this.userService.isEmailRegisterd(control.value,this.id).subscribe(res => {
                    console.log('Check Email Calling'+res);
                    if(res == 0){
                        resolve(null);
                    } else {
                        resolve({ 'isEmailUnique': true });
                    }
                });
            }, 1000);
        });
        return q;
    }     
	
	
  saveUser() {
	  console.log(this.user);
    this.userService.saveUser(this.id, this.user).subscribe(res => {

		this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: res.message});
		setTimeout(() => {
			this.router.navigate(['users']);
		}, 2000);
    });
  }

  logoutUser() {
    this.userService.logoutUser(this.id).subscribe(res => {

      // Display message for 2 seconds
      this.msgs.push({severity: 'success', summary: 'User Updated', detail: res.message});
      setTimeout(() => {
        this.msgs = [];
      }, 2000);

      // Reload User
      this.loadUser();

    });
  }
  
	goBack() {
        this._location.back();
    }


}