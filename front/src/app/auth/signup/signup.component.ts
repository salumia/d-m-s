import { Component, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from '../../user/user.service';
import { Vendor } from '../../user/vendor';
import { Message, SelectItem } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { MessageService } from 'primeng/components/common/messageservice';
import { IndustryService } from '../../contract/industry.service';

import { AuthService } from '../auth.service';
import { Auth } from '../auth';
import { AuthData } from '../auth-response';

import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {
	user: Vendor = {} as Vendor;
	roles: SelectItem[];
	departments: SelectItem[];
	designations: SelectItem[];
	msgs: Message[] = [];
	Userform: FormGroup;
	userSettings: any = {};
	industries: SelectItem[] = [];
	
	showPassword: boolean;

	constructor(private auth: AuthService, private userService: UserService, private router: Router, private fb: FormBuilder, private messageService: MessageService, private industryService:IndustryService) {}

	ngOnInit() {
		if(this.auth.isLoggedIn()){
			this.router.navigate(['dashboard']);
		}
		this.loadIndustries();
		this.userSettings['inputPlaceholderText'] = 'Find Street Address';
		this.userSettings = Object.assign({}, this.userSettings) //Very Important Line to add after modifying settings.
		
		this.Userform = this.fb.group({
			'name': new FormControl('', Validators.required),
			'shop_name': new FormControl('', Validators.required),
			'industry_id': new FormControl('', Validators.required),
			'phone': new FormControl('', Validators.required),
			'username': new FormControl('', Validators.compose([Validators.required]), this.isUsernameUnique.bind(this)),			
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]), this.isEmailUnique.bind(this)),					
			'fax': new FormControl(''),
			'address': new FormControl(''),
			'city': new FormControl('', Validators.required),
			'zip': new FormControl('', Validators.required),
			'password': new FormControl('', Validators.required)
		});
	}
	
	loadIndustries() {
		this.industryService.getIndustryList().subscribe(res => {
			for(let i=0;i< res.length; i++){
				if(res[i].value != 1){
					this.industries.push(res[i]);
				}
			}
			this.industries.unshift({label: 'Select', value: ''});		
		});
	}
	
	isUsernameUnique(control: FormControl) {
		const q = new Promise((resolve, reject) => {
            setTimeout(() => {
                this.userService.isUsernameRegisterd(control.value,0).subscribe(res => {
                    if(res == 0){
                        resolve(null);
                    } else {
						this.msgs.push({severity: 'error', summary: 'Username', detail: 'Username not available'});
                        setTimeout(() => {
                          this.msgs = [];
                        }, 2000);
                        resolve({ 'isUsernameUnique': true });
                    }
                });
            }, 1000);
        });
        return q;
    } 
	
    isEmailUnique(control: FormControl) {
        const q = new Promise((resolve, reject) => {
            setTimeout(() => {
                this.userService.isEmailRegisterd(control.value,0).subscribe(res => {
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
		this.userService.saveVendor(0, this.user).subscribe(res => {
			window.scroll(0,0);
			if(res instanceof HttpErrorResponse) {
				this.updateMessage('Sign up Failed:', res.error.message, 'error');
			} else {
				this.updateMessage('Success :', res.message, 'success');
				setTimeout(() => {
					this.doAuth();
					//this.router.navigate(['vendor-login']);
				}, 2000);
			}
		});
	}
	
	doAuth() {
		let auth: Auth = new Auth(this.user.email, this.user.password);

		this.auth.loginVendor(auth).subscribe(res => {
			if(res instanceof HttpErrorResponse) {
				this.updateMessage('Login Failed :', res.error.message, 'error');				
			} else if(res instanceof AuthData) {
				location.reload();		
			}
		});
	}
	
	private updateMessage(summary:string, detail:string, severity:string) {
		this.msgs = [];
		this.msgs.push({
		  severity: severity,
		  summary: summary,
		  detail: detail
		});
	  }
	
	toggle_password() {
		this.showPassword = !this.showPassword;
    }
	
	autoCompleteCallback1(googleAddress:any){
		if( googleAddress.status == "OK" || googleAddress.response){
			
			if(typeof googleAddress.result == "undefined"){
				var temp = googleAddress.data;
			} else {
				var temp = googleAddress.result;
			}
			this.user.address = temp.formatted_address;
			for (let i = 0; i < temp.address_components.length; i++) {
				
				if(temp.address_components[i].types[0] == "sublocality_level_1" ){
					//console.log("sublocality_level_1 : " + temp.address_components[i].long_name);
				}
				
				if(temp.address_components[i].types[0] == "locality" ){
					//console.log("locality : " + temp.address_components[i].long_name);
					this.user.city = temp.address_components[i].long_name;
				}
				
				if(temp.address_components[i].types[0] == "administrative_area_level_2" ){
					//console.log("City : " + temp.address_components[i].long_name);
				}
				
				if(temp.address_components[i].types[0] == "administrative_area_level_1" ){
					//console.log("State : " + temp.address_components[i].long_name);
				}
				
				if(temp.address_components[i].types[0] == "country" ){
					//console.log("country : " + temp.address_components[i].long_name);
				}
				
				if(temp.address_components[i].types[0] == "postal_code" ){
					//console.log("postal_code : " + temp.address_components[i].long_name);
					this.user.zip = temp.address_components[i].long_name;
				}
			}
		}
	}
}
