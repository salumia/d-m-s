import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PartService } from '../part.service';
import { IndustryService } from '../industry.service';
import { ContractTypeService } from '../contract-type.service';
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
	
	captchaSolved = true;
	selectedContact:string = "";
	
    suggestions: any[];
	
	contractPinModel: boolean = false;
	contractPin: any = "";
	contractPinError: any = "";
	
	constructor(aroute: ActivatedRoute, private router: Router, private contractService: ContractService, private contactService: ContactService, private partService: PartService, private setService: SetService, private industryService: IndustryService, private categoryService: CategoryService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location,  private confirmationService: ConfirmationService, private contractTypeService:ContractTypeService) {
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
		//this.loadIndustries();
		this.getIndustryParts();			
		this.loadContractType();		
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
		
	}
	
	loadContract() {
		// Load Industry
		this.contractService.getContract(this.id).subscribe(res => {
			console.log(res);
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
	/* loadIndustries() {
		this.industryService.getIndustryList().subscribe(res => {
		  this.industries = res;
		  this.industries.unshift({label: 'Select', value: ''});
		  this.loadCategories();		
		});
	} */
	
	loadCategories() {
		//this.categoryService.getCategoryList().subscribe(res => {
		this.categoryService.getIndustryCategoryList(this.loggedInUser.id).subscribe(res => {
		  this.categories = res;
		  this.categories.unshift({label: 'Select', value: null});
		  this.loadSpinner = false;
		  //this.loadContacts();
		});
	}
	
	loadContacts() {
		this.contactService.getContactList(this.loggedInUser.id).subscribe(res => {
		  this.contacts = res;
		  this.contacts.unshift({label: 'Select', value: null});
		  console.log(this.contacts);		  
		});
	}
	
	getIndustryParts() {	
		//if(this.loggedInUser.industry_id > 0){	
		this.partService.getIndustryParts(this.loggedInUser.industry_id,this.loggedInUser.id).subscribe(res => {
			this.industryParts = res;
			console.log(this.industryParts);
		});			
		//}
	}	
	
	getUserSets() {	
		this.setService.getUserSetsArray(this.loggedInUser.id).subscribe(res => {
			this.userSets = res;
			console.log(this.userSets);
		});
	}
    
	saveContract() {
		console.log(this.contract);
		if(this.captchaSolved){
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
				console.log(this.contract);
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
			this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: "Please click on captcha"});	
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
	
	showEditDialog(index){
		//this.selectedPart = this.user_contract_parts[index];
		this.selectedPart = { 
								index:index,
								id:this.user_contract_parts[index].id,
								title:this.user_contract_parts[index].title,
								body:this.user_contract_parts[index].body
							};
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
	
	saveTermChanges(){
		let i = this.selectedPart.index;
		this.user_contract_parts[i].title = this.selectedPart.title;
		this.user_contract_parts[i].body = this.selectedPart.body;
		this.editFormVisible = false;
		console.log(this.selectedPart);
	}
	
	onExpire(data){
		this.captchaSolved = false;
	}
	showResponse(data){
		this.captchaSolved = true;
	}
	
	onSelectContact(event) {
		console.log(event.value);
		this.selectedContact = event.label;
		this.contract.email = event.value;
	}
	
	searchContact(event) {
		this.contract.email = "";
		this.contactService.searchContactList(this.loggedInUser.id,event.query.toLowerCase()).subscribe(res => {	
			this.suggestions = [];
			this.suggestions = res;
			console.log(this.suggestions);
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
}