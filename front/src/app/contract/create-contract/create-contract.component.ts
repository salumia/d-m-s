import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PartService } from '../part.service';
import { IndustryService } from '../industry.service';
import { CategoryService } from '../category.service';
import { SetService } from '../set.service';
import { ContractService } from '../contract.service';

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
	contract: Contract = {};
	msgs: Message[] = [];
	contractform: FormGroup;
	listform: FormGroup;
	loadComponents: boolean = false;
	loggedInUser: any;
	loadSpinner: boolean = false;
	editFormVisible: boolean = false;
	
	industries: SelectItem[];
	categories: SelectItem[];
	contacts: SelectItem[];
	industryParts: SelectItem[] = [];
	userSets: SelectItem[] = [];
	user_contract_parts: any[];
	
	selectedPart: any = {};
	listPart: any;
	listSet: any;
	
	addContactVisible = false;	
	newContactEmail:any = "";

	constructor(aroute: ActivatedRoute, private router: Router, private contractService: ContractService, private contactService: ContactService, private partService: PartService, private setService: SetService, private industryService: IndustryService, private categoryService: CategoryService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location,  private confirmationService: ConfirmationService) {
		aroute.params.subscribe(params => {
			this.id = params['id'];
			this.loadSpinner = true;
		});
	}

	ngOnInit() {
		this.loggedInUser = this.auth.getAuth();
		if(this.id > 0 ){
			this.loadContract();
		}
		this.loadIndustries();		
		this.getUserSets();
		
		this.contractform = this.fb.group({
			'industry_id': new FormControl('', Validators.required),
			'category_id': new FormControl('', Validators.required),			
			'email': new FormControl('')				
		});
		
	}
	
	loadContract() {
		// Load Industry
		this.contractService.getContract(this.id).subscribe(res => {
			console.log(res);
		  this.contract = res;
		  this.user_contract_parts = res.get_contract_parts;
		});
	}
	
	loadIndustries() {
		this.industryService.getIndustryList().subscribe(res => {
		  this.industries = res;
		  this.industries.unshift({label: 'Select', value: ''});
		  this.loadCategories();		
		});
	}
	
	loadCategories() {
		this.categoryService.getCategoryList().subscribe(res => {
		  this.categories = res;
		  this.categories.unshift({label: 'Select', value: ''});
		  this.loadSpinner = false;
		  this.loadContacts();
		});
	}
	
	loadContacts() {
		this.contactService.getContactList(this.loggedInUser.id).subscribe(res => {
		  this.contacts = res;
		  this.contacts.unshift({label: 'Select', value: ''});
		  console.log(this.contacts);		  
		});
	}
	
	getIndustryParts(industry) {	
		if(industry.value > 0){	
			this.partService.getIndustryParts(industry.value,this.loggedInUser.id).subscribe(res => {
				this.industryParts = res;
				console.log(this.industryParts);
			});			
		}
	}	
	
	getUserSets() {	
		this.setService.getUserSetsArray(this.loggedInUser.id).subscribe(res => {
			this.userSets = res;
			console.log(this.userSets);
		});
	}
    
	saveContract() {
		this.loadSpinner = true;
		this.contract.sender_id = this.loggedInUser.id;
		if(this.contract.email != ""){
			this.contract.sender_flag = 1;
			this.contract.receiver_flag = 2;
			this.contract.status = 1 
		}
		this.contractService.saveContract(this.id, this.contract).subscribe(res => {
			if(this.id > 0){
				this.saveContractTerms(res.contracts.id);	
			}else {
				this.saveContractTerms(res.contracts.id);	
			}			
		});
	}
	
	
	saveContractTerms(id) {
		this.contractService.saveContractTerms(id, this.user_contract_parts, this.loggedInUser.id).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: res.message});	
			setTimeout(() => {
				this.router.navigate(['contracts']);
			}, 2000);
		});
	}
	
	showEditDialog(index){
		this.selectedPart = this.user_contract_parts[index];
		this.editFormVisible = true;
		console.log(this.selectedPart);
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
	
	showAddContactDialog() {
		this.addContactVisible = true;
	}
	
	saveContact(){
		this.msgs = [];        
		for (const contact of this.contacts) {
		  if (contact.value === this.newContactEmail) {
			this.msgs.push({severity:'error', summary:'Error ', detail:'This Email is already in your contacts'});
		  }
		}
		
		if(this.msgs.length == 0){
			this.contactService.saveContact(this.loggedInUser.id, this.newContactEmail).subscribe(res => {
				this.contract.email = this.newContactEmail;
				this.msgs.push({severity:'success', summary:'Success ', detail:'Contact Added'});
				this.newContactEmail = "";
				// Reload Contacts
				this.loadContacts();
				setTimeout(() => {
					this.msgs = [];     					
					this.addContactVisible = false;
				}, 2000);
			});
		}
	}
}