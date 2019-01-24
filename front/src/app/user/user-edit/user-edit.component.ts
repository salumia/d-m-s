import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { UserService } from '../user.service';
import { User } from '../user';
import { Message, SelectItem } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { AuthService } from '../../auth/auth.service';
import { MessageService } from 'primeng/components/common/messageservice';
import {Location} from '@angular/common';
declare var google: any;
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
	userSettings: any = {
		inputPlaceholderText: 'This is the placeholder text doring component initialization'
	};
  constructor(aroute: ActivatedRoute, private router: Router, private userService: UserService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location) {
    aroute.params.subscribe(params => {
      this.id = params['id'];
      if(this.id > 0){
		  this.loadSpinner = true;
	  }
    });
  }
	autoCompleteCallback1(event){
		console.log(event);
	}	
  ngOnInit() {

	
		
		this.userSettings['inputPlaceholderText'] = 'This is the placeholder text after doing some external operation after some time';
		this.userSettings = Object.assign({}, this.userSettings) //Very Important Line to add after modifying settings.

	this.loggedInUser = this.auth.getAuth();
	
	if((this.loggedInUser.id != this.id && this.loggedInUser.department == 1) || this.loggedInUser.role == 'admin'){
		this.disableFieldsFlag = false;  
	}


	this.Userform = this.fb.group({
			'name': new FormControl('', Validators.required),
			'shop_name': new FormControl(''),
			'gender': new FormControl('', Validators.required),
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]),this.isEmailUnique.bind(this)),			
			'phone': new FormControl('', Validators.required),
			'fax': new FormControl('', Validators.required),
			'address': new FormControl('', Validators.required),
			'city': new FormControl('', Validators.required),
			'zip': new FormControl('', Validators.required),
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
      { label: 'Male', value: 'male' },
      { label: 'Felmale', value: 'famale' }
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
	
	// initAutocomplete() {
	// 	console.log('working');
	// 	const autocomplete = new google.maps.places.Autocomplete(
	// 			/** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
	// 			{types: ['geocode']});
	// 			const place = autocomplete.getPlace();
	// 			console.log(place);
	// 		//autocomplete.addListener('place_changed', fillInAddress);
	// 	}
    isEmailUnique(control: FormControl) {
        const q = new Promise((resolve, reject) => {
            setTimeout(() => {
                this.userService.isEmailRegisterd(control.value,this.id, 'user').subscribe(res => {
                    console.log('Check Email Calling'+res);
                    if(res == 0){
                        resolve(null);
                    } else {
											this.msgs.push({severity: 'error', summary: 'Email', detail: 'Email already exist!'});
                        setTimeout(() => {
                          this.msgs = [];
                        }, 2000);
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
	
	toggle_password() {
		/* if( $("#newPassword").attr('type') == "text" ){
			$("#newPassword").attr('type',"password");
		} else {
			$("#newPassword").attr('type',"text");
		} */
    }


}
