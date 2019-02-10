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
	userSettings: any = {};
	
	showPassword: boolean;
	
  constructor(aroute: ActivatedRoute, private router: Router, private userService: UserService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location) {
		this.showPassword = false;
		aroute.params.subscribe(params => {
			this.id = params['id'];
			if(this.id > 0){
				this.loadSpinner = true;
			}
		});		
	}
	
  ngOnInit() {

	this.userSettings['inputPlaceholderText'] = 'Enter Area Name';
	this.userSettings = Object.assign({}, this.userSettings) //Very Important Line to add after modifying settings.

	this.loggedInUser = this.auth.getAuth();
	
	if((this.loggedInUser.id != this.id && this.loggedInUser.department == 1) || this.loggedInUser.role == 'admin'){
		this.disableFieldsFlag = false;  
	}


	this.Userform = this.fb.group({
			'name': new FormControl('', Validators.required),
			'shop_name': new FormControl(''),
			/* 'gender': new FormControl('', Validators.required), */
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
	/* this.googleAddress = JSON.parse('{"result":{"address_components":[{"long_name":"Model Town","short_name":"Model Town","types":["sublocality_level_1","sublocality","political"]},{"long_name":"Yamuna Nagar","short_name":"Yamuna Nagar","types":["locality","political"]},{"long_name":"Yamuna Nagar","short_name":"Yamuna Nagar","types":["administrative_area_level_2","political"]},{"long_name":"Haryana","short_name":"HR","types":["administrative_area_level_1","political"]},{"long_name":"India","short_name":"IN","types":["country","political"]},{"long_name":"135001","short_name":"135001","types":["postal_code"]}],"formatted_address" : "#554-A, Model Town, Yamuna Nagar, Haryana 135001, India"},"status":"OK"}'); */

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
		this.userService.saveUser(this.id, this.user).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: res.message});
			setTimeout(() => {
				this.router.navigate(['users']);
			}, 2000);
		});
	}

	logoutUser() {
		this.userService.logoutUser(this.id).subscribe(res => {
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
		this.showPassword = !this.showPassword;
		/* if( googleAddress.status == "OK"){	
			this.user.address = googleAddress.result.formatted_address;
			for (let i = 0; i < 6; i++) {
				
				if(googleAddress.result.address_components[i].types[0] == "sublocality_level_1" ){
					console.log("sublocality_level_1 : " + googleAddress.result.address_components[i].long_name);
				}
				
				if(googleAddress.result.address_components[i].types[0] == "locality" ){
					console.log("locality : " + googleAddress.result.address_components[i].long_name);
					this.user.city = googleAddress.result.address_components[i].long_name;
				}
				
				if(googleAddress.result.address_components[i].types[0] == "administrative_area_level_2" ){
					console.log("City : " + googleAddress.result.address_components[i].long_name);
				}
				
				if(googleAddress.result.address_components[i].types[0] == "administrative_area_level_1" ){
					console.log("State : " + googleAddress.result.address_components[i].long_name);
				}
				
				if(googleAddress.result.address_components[i].types[0] == "country" ){
					console.log("country : " + googleAddress.result.address_components[i].long_name);
				}
				
				if(googleAddress.result.address_components[i].types[0] == "postal_code" ){
					console.log("postal_code : " + googleAddress.result.address_components[i].long_name);
					this.user.zip = googleAddress.result.address_components[i].long_name;
				}
			}
		} */		
    }

	autoCompleteCallback1(googleAddress:any){
		console.log(googleAddress);
		if( googleAddress.status == "OK" || googleAddress.response){
			
			if(typeof googleAddress.result == "undefined"){
				var temp = googleAddress.data;
			} else {
				var temp = googleAddress.result;
			}
			this.user.address = temp.formatted_address;
			for (let i = 0; i < temp.address_components.length; i++) {
				
				if(temp.address_components[i].types[0] == "sublocality_level_1" ){
					console.log("sublocality_level_1 : " + temp.address_components[i].long_name);
				}
				
				if(temp.address_components[i].types[0] == "locality" ){
					console.log("locality : " + temp.address_components[i].long_name);
					this.user.city = temp.address_components[i].long_name;
				}
				
				if(temp.address_components[i].types[0] == "administrative_area_level_2" ){
					console.log("City : " + temp.address_components[i].long_name);
				}
				
				if(temp.address_components[i].types[0] == "administrative_area_level_1" ){
					console.log("State : " + temp.address_components[i].long_name);
				}
				
				if(temp.address_components[i].types[0] == "country" ){
					console.log("country : " + temp.address_components[i].long_name);
				}
				
				if(temp.address_components[i].types[0] == "postal_code" ){
					console.log("postal_code : " + temp.address_components[i].long_name);
					this.user.zip = temp.address_components[i].long_name;
				}
			}
		}
	}

}
