import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { UserService } from '../../user/user.service';
import { ContactService } from '../contact.service';
import { User } from '../../user/user';
import { Message, SelectItem } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { AuthService } from '../../auth/auth.service';
import { MessageService } from 'primeng/components/common/messageservice';
import {Location} from '@angular/common';
declare var google: any;

@Component({
  selector: 'app-contact-edit',
  templateUrl: './contact-edit.component.html',
  styleUrls: ['./contact-edit.component.css']
})

export class ContactEditComponent implements OnInit {
	@ViewChild('documentsChild') documentsChild;
	id: number;
	user_id: number;
	user: any = {};
	contact: any = {};
	search_contact: any = {};
	msgs: Message[] = [];
	Userform: FormGroup;
	Searchform: FormGroup;
	Contactform: FormGroup;
	loggedInUser: any;
	loadSpinner: boolean = false;
	userSettings: any = {};
	newContactEmail:any = "";
	availableNewContacts: any[] = [];
	addUserTab = true;
	searchTab = true;
	contactTab = false;
	
  constructor(aroute: ActivatedRoute, private router: Router, private userService: UserService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location, private contactService: ContactService) {
		aroute.params.subscribe(params => {
			this.id = params['id'];
			if(this.id > 0){
				this.loadSpinner = true;
				this.searchTab = false;
			}
		});		
	}
	
	
	ngOnInit() {
		this.userSettings['inputPlaceholderText'] = 'Enter Area Name';
		this.userSettings = Object.assign({}, this.userSettings) //Very Important Line to add after modifying settings.

		this.loggedInUser = this.auth.getAuth();
	
		this.Searchform = this.fb.group({
			'cc': new FormControl(''),
			'company': new FormControl('', Validators.required),
			'name': new FormControl('', Validators.required),
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]))
		});
		
		this.Contactform = this.fb.group({
			'cc': new FormControl(''),
			'company': new FormControl('', Validators.required),
			'name': new FormControl('', Validators.required),
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]))
		});
		
		this.Userform = this.fb.group({
			'cc': new FormControl(''),
			'company': new FormControl('', Validators.required),
			'name': new FormControl('', Validators.required),
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]),this.isEmailUnique.bind(this)),		
			'username': new FormControl('', Validators.compose([Validators.required]), this.isUsernameUnique.bind(this)),'phone': new FormControl('', Validators.required),
			'fax': new FormControl('', Validators.required),
			'address': new FormControl('', Validators.required),
			'city': new FormControl('', Validators.required),
			'zip': new FormControl('', Validators.required),
			'password': new FormControl('')
		});

		if(this.id > 0 ){
			this.loadContact();
		} else {
			this.loadAvailableNewContacts();
		}
	}
  
	loadContact() {
		// Load User
		this.contactService.getContact(this.id).subscribe(res => {
			this.contact = res;
			this.user_id = res.user_id;
			this.loadUser(res.type);
			console.log(this.contact);
		});

	}
	
	loadUser(role) {
		// Load User
		if(role == 'user'){
			this.userService.getUser(this.user_id).subscribe(res => {	
			console.log(res);
			console.log(typeof res.contact_added_by);
			  if(res.contact_added_by == null || res.contact_added_by == 0){
				this.addUserTab = false;
				this.contactTab = true;
			  }
			  this.user = res;			  			 
			  this.user.company = this.contact.company;			  			 
			  this.user.cc = this.contact.cc;			  			 
			  this.loadSpinner = false;
			});
		} else {
			this.contactTab = true;
			this.addUserTab = false;
			this.loadSpinner = false;
		}
	}
	
	isUsernameUnique(control: FormControl) {
		const q = new Promise((resolve, reject) => {
            setTimeout(() => {
                this.userService.isUsernameRegisterd(control.value,this.user_id, 'user').subscribe(res => {
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
                this.userService.isEmailRegisterd(control.value,this.user_id, 'user').subscribe(res => {
                    if(res == 0){
                        resolve(null);
                    } else {
						this.msgs.push({severity: 'error', summary: 'Email', detail: 'Email already registered with system. Use Search Client Tab to add contact'});
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
	
	loadAvailableNewContacts() {
		this.contactService.emailSuggestions(this.loggedInUser.id).subscribe(res => {
			this.availableNewContacts = res;
			this.availableNewContacts.unshift({label: 'Select', value: ''});
		});        
    }
	
	updateContact() {
		console.log(this.contact);
		this.addContact(this.contact);
	}
	
	saveSearchContact() {
		console.log(this.search_contact);
		this.addContact(this.search_contact);
	}
	
	saveContact() {
		this.user.contact_added_by = this.loggedInUser.id;
		this.userService.saveUser(this.user_id, this.user).subscribe(res => {
			this.contact.cc = this.user.cc;
			this.contact.company = this.user.company;
			this.contact.name = this.user.name;
			this.contact.email = this.user.email;
			this.addContact(this.contact);			
		});
	}
	
	addContact(contact){
		console.log(contact);
		this.contactService.saveContact(this.loggedInUser.id, contact, this.id).subscribe(res => {
			if(this.id > 0 ){
				this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: "Contact Updated"});
			} else {
				this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: "Contact Added"});
			}
			
			setTimeout(() => {
				this.router.navigate(['contacts']);
			}, 2000);
		});		
	}
  
	goBack() {
        this._location.back();
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
