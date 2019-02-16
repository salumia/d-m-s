import { Component, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from '../../user/user.service';
import { Vendor } from '../../user/vendor';
import { Message, SelectItem } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { MessageService } from 'primeng/components/common/messageservice';

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

	constructor(private userService: UserService, private router: Router, private fb: FormBuilder, private messageService: MessageService) {}

	ngOnInit() {
		this.userSettings['inputPlaceholderText'] = 'Find Street Address';
		this.userSettings = Object.assign({}, this.userSettings) //Very Important Line to add after modifying settings.
		
		this.Userform = this.fb.group({
			'name': new FormControl('', Validators.required),
			'shop_name': new FormControl('', Validators.required),
			'phone': new FormControl('', Validators.required),
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]), this.isEmailUnique.bind(this)),					
			'fax': new FormControl('', Validators.required),
			'address': new FormControl(''),
			'city': new FormControl('', Validators.required),
			'zip': new FormControl('', Validators.required),
			'password': new FormControl('', Validators.required)
		});
	}

    isEmailUnique(control: FormControl) {
        const q = new Promise((resolve, reject) => {
            setTimeout(() => {
                this.userService.isEmailRegisterd(control.value,0).subscribe(res => {
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
		this.userService.saveVendor(0, this.user).subscribe(res => {
			if(res instanceof HttpErrorResponse) {
				this.updateMessage('Sign up Failed:', res.error.message, 'error');
			} else {
				this.updateMessage('Success :', res.message, 'success');
				setTimeout(() => {
					this.router.navigate(['vendor-login']);
				}, 2000);
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
