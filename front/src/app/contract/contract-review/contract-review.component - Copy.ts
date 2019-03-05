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
  selector: 'app-contract-review',
  templateUrl: './contract-review.component.html',
  styleUrls: ['./contract-review.component.css']
})

export class ContractReviewComponent implements OnInit {
@ViewChild('documentsChild') documentsChild;
	id: number;
	modificationCounter: number = 0;
	contract: Contract = {} as Contract;
	msgs: Message[] = [];
	contractform: FormGroup;
	listform: FormGroup;
	loadComponents: boolean = false;
	loggedInUser: any;
	loadSpinner: boolean = false;
	editFormVisible: boolean = false;
	showCompareBox: boolean = false;
	
	senderActive: boolean = false;
	
	industries: SelectItem[];
	categories: SelectItem[];
	contacts: SelectItem[];
	industryParts: SelectItem[] = [];
	userSets: SelectItem[] = [];
	user_contract_parts: any[] = [];
	
	deleted_contract_parts: any[] = [];
	edited_contract_parts: any[] = [];
	added_contract_parts: any[] = [];
	
	selectedPart: any = {};
	listPart: any;
	listSet: any;
	
	compareData: any = '';
	
	acceptButtonVisible: boolean = true;
	
	captchaSolved = false;

	constructor(aroute: ActivatedRoute, private router: Router, private contractService: ContractService, private contactService: ContactService, private partService: PartService, private setService: SetService, private industryService: IndustryService, private categoryService: CategoryService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location,  private confirmationService: ConfirmationService) {
		aroute.params.subscribe(params => {
			this.id = params['id'];
			this.loadSpinner = true;
		});
	}

	ngOnInit() {
		this.loggedInUser = this.auth.getAuth();
		//this.loadIndustries();
		this.getIndustryParts();
		if(this.id > 0 ){
			this.loadContract();
		}		
	}
	
	loadContract() {
		this.contractService.getContract(this.id).subscribe(res => {	
			this.contract = res;		
			this.setUserType();			
			this.user_contract_parts = res.get_contract_parts;
			this.loadSpinner = false;
			this.updateNotifications();
			console.log(this.user_contract_parts);
		});
	}
	
	updateNotifications(){
		this.contractService.updateNotifications(this.loggedInUser.id, this.loggedInUser.role, this.id, 'review').subscribe(res => {	
			
		});
	}
	
	setUserType(){
		console.log(typeof this.loggedInUser.role);
		console.log(typeof this.contract.receiver_role);
		if(this.contract.receiver_id == this.loggedInUser.id && this.loggedInUser.role == this.contract.receiver_role ){
			this.senderActive = false;
		} else {
			this.senderActive = true;
		}	
		console.log("senderActive");
		console.log(this.senderActive);
	}
	
	loadIndustries() {
		this.industryService.getIndustryList().subscribe(res => {
		  this.industries = res;
		  this.industries.unshift({label: 'Select Industry', value: ''});		
		});
	}
	
	/* getIndustryParts(industry) {	
		if(industry.value > 0){	
			this.partService.getIndustryParts(industry.value,this.loggedInUser.id, this.loggedInUser.role).subscribe(res => {
				this.industryParts = res;
				console.log(this.industryParts);
			});			
		}
	} */
	
	getIndustryParts() {	
		if(this.loggedInUser.role == 'vendor'){	
			this.partService.getIndustryParts(this.loggedInUser.industry_id,this.loggedInUser.id, this.loggedInUser.role).subscribe(res => {
				this.industryParts = res;
				console.log(this.industryParts);
			});			
		}
	}	
	
	saveContractTerms(id) {
		this.contractService.saveContractTerms(id, this.user_contract_parts, this.loggedInUser.id).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: res.message});		
			this.loadSpinner = false;
			setTimeout(() => {
				this.router.navigate(['contracts']);
			}, 2000);
		});
	}
	
	showEditDialog(index){	
		if(this.user_contract_parts[index].newly_added == 0){
			let findIndex = this.edited_contract_parts.findIndex(part => part.part_id === this.user_contract_parts[index].id);
			if( findIndex >= 0){
				this.edited_contract_parts[findIndex] = {
					part_id:this.user_contract_parts[index].id,
					body:this.user_contract_parts[index].body,
					title:this.user_contract_parts[index].title,
					contract_id:this.id
				};
			} else {
				this.edited_contract_parts.push({
					part_id:this.user_contract_parts[index].id,
					body:this.user_contract_parts[index].body,
					title:this.user_contract_parts[index].title,
					contract_id:this.id
				});
			}
			//this.user_contract_parts[index].is_edited = 1;
			this.user_contract_parts[index].tmp_edited = 1;
			console.log(this.edited_contract_parts);
		}		
		
		//this.selectedPart = this.user_contract_parts[index];
		this.selectedPart = { 
								index:index,
								id:this.user_contract_parts[index].id,
								title:this.user_contract_parts[index].title,
								body:this.user_contract_parts[index].body
							};
		this.editFormVisible = true;
		
		this.modificationCounter = this.modificationCounter + 1;
		this.showProperButton();
	}
	
	reloadTerm(index){
		this.user_contract_parts[index].tmp_deleted = 0;
		//this.user_contract_parts[index].is_deleted = 0;
		this.modificationCounter = this.modificationCounter - 1;
		this.showProperButton();
	}
	
	reloadDeletedTerm(index){
		this.user_contract_parts[index].is_deleted = 0;
		this.user_contract_parts[index].tmp_modified = 1;
		this.modificationCounter = this.modificationCounter + 1;
		this.showProperButton();
	}
	
	deleteTerm(index){	
		if(this.user_contract_parts[index].newly_added == 0){
			let findIndex = this.edited_contract_parts.findIndex(part => part.part_id === this.user_contract_parts[index].id);
			if( findIndex >= 0){		
				this.user_contract_parts[index].title = this.edited_contract_parts[findIndex].title;
				this.user_contract_parts[index].body = this.edited_contract_parts[findIndex].body;
				this.edited_contract_parts.splice(findIndex,1);
			}
			
			this.user_contract_parts[index].tmp_edited = 0;
			this.user_contract_parts[index].tmp_deleted = 1;
		} else {
			this.user_contract_parts.splice(index, 1);
		}
		
		//this.user_contract_parts[index].is_deleted = 1;
		//this.user_contract_parts.splice(index, 1);
		
		this.modificationCounter = this.modificationCounter + 1;

		this.showProperButton();
	}
	
	showProperButton(){
		if(this.modificationCounter == 0){
			this.acceptButtonVisible = true;
		} else {
			this.acceptButtonVisible = false;
		}
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
		this.user_contract_parts.push({title:event.label, body:event.value.body, is_edited: 0, is_deleted: 0, modified: 0, newly_added: 1});		
	}
	
	sendBackContract(){
		if(this.captchaSolved){
			console.log(this.user_contract_parts);
			console.log(this.edited_contract_parts);
			this.loadSpinner = true;
			this.contractService.updateContractTerms(this.id, this.loggedInUser.id, this.user_contract_parts, this.edited_contract_parts, this.senderActive).subscribe(res => {
				this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Contract sent back successfully'});		
				setTimeout(() => {
					this.router.navigate(['contracts']);
				}, 2000);
			}); 
		} else {
			this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: "Please click on captcha"});	
		}
	}
	
	acceptContract(){
		if(this.captchaSolved){
			this.loadSpinner = true;
			this.contractService.updateContractStatus(this.id, 2).subscribe(res => {
				this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Contract Accepted'});		
				setTimeout(() => {
					this.router.navigate(['contracts']);
				}, 2000);
			});	
		} else {
			this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: "Please click on captcha"});	
		}		
	}
	
	rejectContract(){
		if(this.captchaSolved){
			this.loadSpinner = true;
			this.contractService.updateContractStatus(this.id, 3).subscribe(res => {
				this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Contract Rejected'});		
				setTimeout(() => {
					this.router.navigate(['contracts']);
				}, 2000);
			});
		} else {
			this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: "Please click on captcha"});	
		}
	}
	
	showComparison(index){
		this.showCompareBox = true;		
		this.contractService.getPartComparisonData(this.user_contract_parts[index].id).subscribe(res => {		
			this.compareData = res.data;
			console.log(this.compareData);
		});
	}
	
	goBack() {
        this._location.back();
    }
	
	onHideCompareBox(){
		this.compareData = "";
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
}