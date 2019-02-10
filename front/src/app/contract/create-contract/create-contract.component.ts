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
	contract: Contract;
	msgs: Message[] = [];
	contractform: FormGroup;
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

	constructor(aroute: ActivatedRoute, private router: Router, private contractService: ContractService, private contactService: ContactService, private partService: PartService, private setService: SetService, private industryService: IndustryService, private categoryService: CategoryService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location,  private confirmationService: ConfirmationService) {
		aroute.params.subscribe(params => {
			this.id = params['id'];
			if(this.id > 0){
			  this.loadSpinner = true;
			}
		});
	}

	ngOnInit() {
		this.loggedInUser = this.auth.getAuth();
		this.loadIndustries();
		this.loadCategories();
		this.loadContacts();
		this.getUserSets();
		this.contractform = this.fb.group({
			'industry_id': new FormControl('', Validators.required),
			'category_id': new FormControl('', Validators.required),			
			'email': new FormControl('')				
		});
		this.user_contract_parts = [
			{ title: 'first', body: "The story begins as Don Vito Corleone, the head of a New York Mafia family, oversees his daughter's wedding. His beloved son Michael has just come home from the war, but does not intend to become part of his father's business. Through Michael's life the nature of the family business becomes clear. The business of the family is just like the head of the family, kind and benevolent to those who give respect, but given to ruthless violence whenever anything stands against the good of the family." },
			{ title: 'second', body: "His beloved son Michael has just come home from the war, but does not intend to become part of his father's business. Through Michael's life the nature of the family business becomes clear. The business of the family is just like the head of the family, kind and benevolent to those who give respect, but given to ruthless violence whenever anything stands against the good of the family." },
			{ title: 'Third', body: 'Lorem Ipsum for 3rd term' }
		];
		
	}
	
	loadIndustries() {
		this.industryService.getIndustryList().subscribe(res => {
		  this.industries = res;
		  this.industries.unshift({label: 'Select', value: ''});
		});
	}
	
	loadCategories() {
		this.categoryService.getCategoryList().subscribe(res => {
		  this.categories = res;
		  this.categories.unshift({label: 'Select', value: ''});
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
		this.setService.getUserSets(this.loggedInUser.id).subscribe(res => {
			this.userSets = res;
			console.log(this.userSets);
		});
	}
    
	saveContract() {
		/* this.contract.sender_id = this.loggedInUser.id;
		console.log(this.contract);
		this.contractService.saveContract(this.id, this.contract).subscribe(res => {
			console.log(res);
			this.saveContractTerms(res.contracts.id);
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: res.message});			
		}); */
	}
	
	saveContractTerms(id) {
		console.log(id);
		console.log(this.user_contract_parts);
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
		console.log(set);
		this.confirmationService.confirm({
			message: 'Are you sure?',
            header: 'Replace Set Confirmation',
            icon: 'pi pi-info-circle',
            accept: () => {
				this.user_contract_parts = set.value;
			}
		});
	}
	
	onSelectTerm(event){
		console.log(event);
		this.user_contract_parts.push({title:event.label, body:event.value.body});
	}
	
	goBack() {
        this._location.back();
    }
}