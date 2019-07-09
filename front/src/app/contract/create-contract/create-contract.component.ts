import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PartService } from '../part.service';
import { IndustryService } from '../industry.service';
import { ContractTypeService } from '../contract-type.service';
import { CategoryService } from '../category.service';
import { SetService } from '../set.service';
import { ContractService } from '../contract.service';
import { UserService } from '../../user/user.service';

import { ContactService } from '../../contact/contact.service';
import { Part } from '../part';
import { Industry } from '../industry';
import { Contract } from '../contract';
import { Message, SelectItem, ConfirmationService } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { AuthService } from '../../auth/auth.service';
import { MessageService } from 'primeng/components/common/messageservice';
import { Location} from '@angular/common';

@Component({
  selector: 'app-create-contract',
  templateUrl: './create-contract.component.html',
  styleUrls: ['./create-contract.component.css']
})
export class CreateContractComponent implements OnInit {
@ViewChild('documentsChild') documentsChild;
	id: number;
	contract: Contract = {} as Contract;;
	msgs: Message[] = [];
	contractform: FormGroup;
	listform: FormGroup;
	loadComponents: boolean = false;
	loggedInUser: any;
	loadSpinner: boolean = false;
	editFormVisible: boolean = false;
	
	contract_types: SelectItem[];
	industries: SelectItem[];
	categories: SelectItem[];
	contacts: SelectItem[];
	industryParts: SelectItem[] = [];
	userSets: SelectItem[] = [];
	user_contract_parts: any[] = [];
	
	selectedPart: any = {};
	listPart: any;
	listSet: any;

	selectedContact:string = "";
	
    suggestions: any[];
	
	contractPinModel: boolean = false;
	contractPin: any = "";
	contractPinError: any = "";
	
	/************* CONTACT Objects ************/
	showContactPopup: boolean = false;
	selectedVendor: number = 0;
	user: any = {};
	contact: any = {};
	search_contact: any = {};
	Userform: FormGroup;
	Searchform: FormGroup;
	
	userSettings: any = {};
	
	addUserTab = true;
	searchTab = true;
	loadContactSpinner: boolean = false;
	
	newContactSuggestions: any[];
	search_contact_label = '';
	
	constructor(aroute: ActivatedRoute, private router: Router, private contractService: ContractService, private contactService: ContactService, private partService: PartService, private setService: SetService, private industryService: IndustryService, private categoryService: CategoryService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location,  private confirmationService: ConfirmationService, private contractTypeService:ContractTypeService, private userService: UserService) {
		aroute.params.subscribe(params => {
			this.id = params['id'];
			this.loadSpinner = true;
		});
	}

	ngOnInit() {
		this.loggedInUser = this.auth.getAuth();
		if(this.selectedVendor == 0 ){						
			this.selectedVendor = this.loggedInUser.id;
		}
		if(this.id > 0 ){
			this.loadContract();
		}		
		
		this.loadContractType();
		
		this.getIndustryParts();		
		this.getUserSets();
		
		this.contractform = this.fb.group({
			'type': new FormControl('', Validators.required),
			'name': new FormControl('', Validators.required),
			'description': new FormControl('', Validators.required),
			'industry_id': new FormControl(''),
			'category_id': new FormControl('', Validators.required),			
			'email': new FormControl(''),			
			'contact': new FormControl('')			
		});
		
		this.Userform = this.fb.group({
			'cc': new FormControl(''),
			'company': new FormControl('', Validators.required),
			'name': new FormControl('', Validators.required),
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]),this.isEmailUnique.bind(this)),		
			'username': new FormControl('', Validators.compose([Validators.required]), this.isUsernameUnique.bind(this)),'phone': new FormControl('', Validators.required),
			'fax': new FormControl(''),
			'address': new FormControl('', Validators.required),
			'city': new FormControl('', Validators.required),
			'zip': new FormControl('', Validators.required),
			'password': new FormControl('')
		});
		
		this.Searchform = this.fb.group({
			'cc': new FormControl(''),
			'company': new FormControl('', Validators.required),
			'name': new FormControl('', Validators.required),
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]))
		});
		
	}
	
	saveSearchContact() {
		this.addContact(this.search_contact);
	}
	
	saveContact() {
		this.user.contact_added_by = this.selectedVendor;
		this.userService.saveUser(0, this.user).subscribe(res => {
			this.contact.cc = this.user.cc;
			this.contact.company = this.user.company;
			this.contact.name = this.user.name;
			this.contact.email = this.user.email;
			this.addContact(this.contact);			
		});
	}
	
	addContact(contact){
		this.contactService.saveContact(this.selectedVendor, contact, 0).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: "Contact Added"});
			this.showContactPopup = false;
			this.Userform.reset();
			this.Searchform.reset();
		});		
	}
	
	loadContract() {
		// Load Contract
		this.contractService.getContract(this.id).subscribe(res => {
		  this.contract = res;
		  this.user_contract_parts = res.get_contract_parts;
		});
	}
	
	loadContractType() {
		this.contractTypeService.getContractTypesList().subscribe(res => {
		  this.contract_types = res;
		  this.contract_types.unshift({label: 'Select', value: ''});
		  this.loadCategories();
		});
	}
	
	loadCategories() {
		this.categoryService.getIndustryCategoryList(this.loggedInUser.id).subscribe(res => {
		  this.categories = res;
		  this.categories.unshift({label: 'Select', value: null});
		  this.loadSpinner = false;
		});
	}
	
	getIndustryParts() {		
		this.partService.getIndustryParts(this.loggedInUser.industry_id,this.loggedInUser.id).subscribe(res => {
			this.industryParts = res;
		});			
	}	
	
	getUserSets() {	
		this.setService.getUserSetsArray(this.loggedInUser.id).subscribe(res => {
			this.userSets = res;
		});
	}
    
	saveContract() {
		if(this.user_contract_parts.length > 0){				
			this.loadSpinner = true;
			this.contract.sender_id = this.loggedInUser.id;
			if(typeof this.contract.email == "undefined" || this.contract.email == "" || this.contract.email == null){
				
				this.contractService.saveContract(this.id, this.contract).subscribe(res => {
					if(this.id > 0){
						this.saveContractTerms(res.contracts.id);	
					}else {
						this.saveContractTerms(res.contracts.id);	
					}			
				});
				
			}else{
				if(typeof this.contract.pin == "undefined" || this.contract.pin == "" || this.contract.pin == null){
					this.contractPinModel = true;
				} else {
				
					this.contract.sender_flag = 1;
					this.contract.receiver_flag = 2;
					this.contract.status = 1 ;	

					this.contractService.saveContract(this.id, this.contract).subscribe(res => {
						if(this.id > 0){
							this.saveContractTerms(res.contracts.id);	
						}else {
							this.saveContractTerms(res.contracts.id);	
						}			
					});
				}
			}
		} else {
			this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: "There must be some terms to create the contract"});	
		}
	}
	
	saveContractTerms(id) {
		this.contractService.saveContractTerms(id, this.user_contract_parts, this.loggedInUser.id).subscribe(res => {
			var temMsg = "Contract saved successfully";
			if(this.contract.status > 0){
				temMsg = "Contract sent successfully";
			}
			this.contract.status == 0
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: temMsg});	
			setTimeout(() => {
				this.router.navigate(['contracts']);
			}, 2000);
		});
	}
	
	showContactDialog(){
		this.showContactPopup = true;
	}
	
	showEditDialog(index){
		this.selectedPart = { 
								index:index,
								id:this.user_contract_parts[index].id,
								title:this.user_contract_parts[index].title,
								body:this.user_contract_parts[index].body
							};
		this.editFormVisible = true;
	}
	
	deleteTerm(index){
		this.user_contract_parts.splice(index, 1);
	}
	
	onSelectSet(set){
		this.confirmationService.confirm({
			message: 'Are you sure?',
            header: 'Replace Set Confirmation',
            icon: 'pi pi-info-circle',
            accept: () => {
				this.listSet = {};
				this.user_contract_parts = set.value;	
			},
			reject: () => {}
		});
	}
	
	onSelectTerm(event){
		this.listPart = {};
		this.user_contract_parts.push({title:event.label, body:event.value.body});		
	}
	
	goBack() {
        this._location.back();
    }
	
	saveTermChanges(){
		let i = this.selectedPart.index;
		this.user_contract_parts[i].title = this.selectedPart.title;
		this.user_contract_parts[i].body = this.selectedPart.body;
		this.editFormVisible = false;
	}
	
	onSelectContact(event) {
		this.selectedContact = event.label;
		this.contract.email = event.value;
	}
	
	searchContact(event) {
		this.contract.email = "";
		this.contactService.searchContactList(this.loggedInUser.id,event.query.toLowerCase()).subscribe(res => {	
			this.suggestions = [];
			this.suggestions = res;
		});
    }
	
	validatePIN(){
		this.contractPinError = "";
		if(this.contractPin != ""){
			this.contract.pin = this.contractPin;			
			this.contractPinModel = false;	
			this.saveContract();			
		} else {
			this.contractPinError = "Please enter contract PIN";
		}
	
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

	isUsernameUnique(control: FormControl) {
		const q = new Promise((resolve, reject) => {
            setTimeout(() => {
                this.userService.isUsernameRegisterd(control.value,0, 'user').subscribe(res => {
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
                this.userService.isEmailRegisterd(control.value,0, 'user').subscribe(res => {
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

	onSelectEmail(event) {
		this.search_contact_label = event.label;
		this.search_contact.email = event.value;
	}
	
	searchEmail(event) {
		this.search_contact.email = "";
		this.contactService.emailSuggestionList(this.selectedVendor,event.query.toLowerCase()).subscribe(res => {	
			this.newContactSuggestions = [];
			this.newContactSuggestions = res;
		});
    }    
	
}