import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { UserService } from '../user.service';
import { IndustryService } from '../../contract/industry.service';
import { Vendor } from '../vendor';
import { Message, SelectItem } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { AuthService } from '../../auth/auth.service';
import { MessageService } from 'primeng/components/common/messageservice';
import { Location} from '@angular/common';

@Component({
  selector: 'app-vendor-edit',
  templateUrl: './vendor-edit.component.html',
  styleUrls: ['./vendor-edit.component.css']
})
export class VendorEditComponent implements OnInit {
	@ViewChild('documentsChild') documentsChild;
	id: number;
	user: Vendor = {} as Vendor;
	msgs: Message[] = [];
	Userform: FormGroup;
	loggedInUser: any;
	loadSpinner: boolean = false;
	editMode: boolean = false;
	userSettings: any = {};
	industries: SelectItem[] = [];
		
	showPassword: boolean;
	
  constructor(aroute: ActivatedRoute, private router: Router, private userService: UserService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location, private industryService:IndustryService) {
	  this.showPassword = false;
    aroute.params.subscribe(params => {
      this.id = params['id'];
      if(this.id > 0){
		  this.editMode = true;
		  this.loadSpinner = true;
	  }
    });
  }

  ngOnInit() {
	this.loadIndustries();
	this.userSettings['inputPlaceholderText'] = 'Enter Area Name';
	this.userSettings = Object.assign({}, this.userSettings) //Very Important Line to add after modifying settings.
	
	this.loggedInUser = this.auth.getAuth();
	
	this.Userform = this.fb.group({
			'name': new FormControl('', Validators.required),
			'shop_name': new FormControl('', Validators.required),
			'industry_id': new FormControl('', Validators.required),		
			'username': new FormControl('', Validators.compose([Validators.required]),this.isUsernameUnique.bind(this)),			
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]),this.isEmailUnique.bind(this)),			
			'phone': new FormControl('', Validators.required),
			'fax': new FormControl('', Validators.required),
			'address': new FormControl('', Validators.required),
			'city': new FormControl('', Validators.required),
			'zip': new FormControl('', Validators.required),
			'password': new FormControl('')
		});
		
	  if(this.id > 0 ){
		this.loadUser();
	  }else{
		this.Userform.controls['password'].setValidators(Validators.required);
	  }
  }
  
  loadUser() {	
    this.userService.getVendor(this.id).subscribe(res => {
      this.user = res;
      this.loadSpinner = false;
    });

  }
	isUsernameUnique(control: FormControl) {
	  const q = new Promise((resolve, reject) => {
            setTimeout(() => {
                this.userService.isUsernameRegisterd(control.value, this.id, 'vendor').subscribe(res => {
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
                this.userService.isEmailRegisterd(control.value, this.id, 'vendor').subscribe(res => {
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
	
	saveUser() {
		this.loadSpinner = true;
		this.userService.saveVendor(this.id, this.user).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: res.message});
			setTimeout(() => {
				if(this.loggedInUser.role == 'vendor'){
					this.router.navigate(['dashboard']);
				} else if(this.loggedInUser.role == 'user'){
					this.router.navigate(['dashboard']);
				} else {
					this.router.navigate(['vendors']);
				}			
			}, 2000);
		});
	}

	logoutUser() {
		this.userService.logoutUser(this.id).subscribe(res => {
		  // Display message for 2 seconds
		  this.msgs.push({severity: 'success', summary: 'Vendor Updated', detail: res.message});
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
