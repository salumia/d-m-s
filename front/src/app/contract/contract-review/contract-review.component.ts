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
	showDigitalSignBox: boolean = false;
	
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
	
	captchaSolved = true;
	
	
	acceptToS: boolean = true;
	digitalSign:string = '';
	tosError:string = "";
	digitalSignError:string = "";
	
	contractPin: any = "";
	contractPinError: any = "";
	
	terms: string = '';

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
			this.loadTOS();
		}		
	}
	
	loadContract() {
		this.contractService.getContract(this.id).subscribe(res => {	
			this.contract = res;		
			this.setUserType();			
			this.user_contract_parts = res.get_contract_parts;
			this.updateNotifications();
			if(this.contract.status == 1 && this.senderActive && this.contract.sender_flag == 2 ){
				this.loadSpinner = false;
			} else if( this.contract.status == 1 && !this.senderActive && this.contract.receiver_flag == 2 ){
				this.loadSpinner = false;				
			} else if( this.contract.status == 2 && this.senderActive && this.contract.sender_flag == 1 ){
				this.loadSpinner = false;				
			} else if( this.contract.status == 2 && !this.senderActive && this.contract.receiver_flag == 1 ){
				this.loadSpinner = false;				
			} else {
				this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: "You don't have access."});
				setTimeout(() => {
								this.router.navigate(['contracts']);
							}, 2000);				
			}
		});
	}
	
	loadTOS() {		
		this.contractService.getTermsOfService().subscribe(res => {
			this.terms = res.tos;
		});
	}
	
	updateNotifications(){
		this.contractService.updateNotifications(this.loggedInUser.id, this.loggedInUser.role, this.id, 'review').subscribe(res => {	
			
		});
	}
	
	setUserType(){
		if(this.contract.receiver_id == this.loggedInUser.id && this.loggedInUser.role == this.contract.receiver_role ){
			this.senderActive = false;
		} else {
			this.senderActive = true;
		}
	}
	
	loadIndustries() {
		this.industryService.getIndustryList().subscribe(res => {
		  this.industries = res;
		  this.industries.unshift({label: 'Select Industry', value: ''});		
		});
	}
	
	getIndustryParts() {	
		if(this.loggedInUser.role == 'vendor'){	
			this.partService.getIndustryParts(this.loggedInUser.industry_id,this.loggedInUser.id, this.loggedInUser.role).subscribe(res => {
				this.industryParts = res;
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
		this.selectedPart = { 
								index:index,
								id:this.user_contract_parts[index].id,
								title:this.user_contract_parts[index].title,
								body:this.user_contract_parts[index].body
							};
		this.editFormVisible = true;
	}
	
	reloadTerm(index){
		this.user_contract_parts[index].tmp_deleted = 0;
		//this.user_contract_parts[index].is_deleted = 0;
		this.modificationCounter = this.modificationCounter - 1;
		this.showProperButton();
		
		let findIndex = this.edited_contract_parts.findIndex(part => part.part_id === this.user_contract_parts[index].id);
		if( findIndex >= 0){
			if(this.edited_contract_parts[findIndex].type == 'deleted'){
				this.edited_contract_parts.splice(findIndex,1);
			}
		}
	}
	
	reloadDeletedTerm(index){
		this.user_contract_parts[index].is_deleted = 0;
		this.user_contract_parts[index].tmp_modified = 1;
		this.modificationCounter = this.modificationCounter + 1;
		this.showProperButton();
		
		let findIndex = this.edited_contract_parts.findIndex(part => part.part_id === this.user_contract_parts[index].id);
		if( findIndex >= 0){
			this.edited_contract_parts[findIndex].type = 'reload';
		} else {
			this.edited_contract_parts.push({
				part_id:this.user_contract_parts[index].id,
				body:this.user_contract_parts[index].body,
				title:this.user_contract_parts[index].title,
				contract_id:this.id,
				type:'reload'
			});
		}		
	}
	
	deleteTerm(index){	
		if(this.user_contract_parts[index].newly_added == 0){
			let findIndex = this.edited_contract_parts.findIndex(part => part.part_id === this.user_contract_parts[index].id);
			if( findIndex >= 0){		
				this.user_contract_parts[index].title = this.edited_contract_parts[findIndex].title;
				this.user_contract_parts[index].body = this.edited_contract_parts[findIndex].body;
				//this.edited_contract_parts.splice(findIndex,1);
				this.edited_contract_parts[findIndex].type = 'deleted';
			} else {
				this.edited_contract_parts.push({
					part_id:this.user_contract_parts[index].id,
					body:this.user_contract_parts[index].body,
					title:this.user_contract_parts[index].title,
					contract_id:this.id,
					type:'deleted'
				});
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
			if(this.validatePIN()){
				this.loadSpinner = true;
				this.contractService.updateContractTerms(this.id, this.loggedInUser.id, this.user_contract_parts, this.edited_contract_parts, this.senderActive).subscribe(res => {
					this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Contract sent back successfully'});		
					setTimeout(() => {
						this.router.navigate(['contracts']);
					}, 2000);
				}); 
			}						
		} else {
			this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: "Please click on captcha"});	
		}
	}
	
	checkToS(){
		this.tosError = "";
		this.digitalSignError = "";
		if(this.acceptToS){
			if(this.digitalSign != ""){
				this.showDigitalSignBox = false;
				this.loadSpinner = true;
				let status = 2;
				if(this.contract.status == 2){
					status = 4;
				}
				this.contractService.updateContractStatus(this.id, status, this.digitalSign, this.senderActive).subscribe(res => {
					this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Contract Accepted'});		
					setTimeout(() => {
						this.router.navigate(['contracts']);
					}, 2000);
				});
			} else {
				this.digitalSignError = "Please type your signature";
			}
		} else {
			this.tosError = "Please accept the terms of service";
		}
		
	}
	
	acceptContract(){
		if(this.captchaSolved){
			if(this.validatePIN()){
				this.showDigitalSignBox = true;
			}		
		} else {
			this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: "Please click on captcha"});	
		}		
	}
	
	rejectContract(){
		if(this.captchaSolved){
			if(this.validatePIN()){
				this.loadSpinner = true;
				this.contractService.updateContractStatus(this.id, 3).subscribe(res => {
					this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Contract Rejected'});		
					setTimeout(() => {
						this.router.navigate(['contracts']);
					}, 2000);
				});
			}				
		} else {
			this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: "Please click on captcha"});	
		}
	}
	
	showComparison(index){
		this.showCompareBox = true;		
		this.contractService.getPartComparisonData(this.user_contract_parts[index].id).subscribe(res => {		
			this.compareData = res.data;
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
		if(this.user_contract_parts[i].title != this.selectedPart.title || this.user_contract_parts[i].body != this.selectedPart.body){
						
					
			if(this.user_contract_parts[i].newly_added == 0){
				let findIndex = this.edited_contract_parts.findIndex(part => part.part_id === this.user_contract_parts[i].id);
				if( findIndex >= 0){
					this.edited_contract_parts[findIndex] = {
						part_id:this.user_contract_parts[i].id,
						body:this.user_contract_parts[i].body,
						title:this.user_contract_parts[i].title,
						new_body:this.selectedPart.body,
						new_title:this.selectedPart.title,
						contract_id:this.id,
						type:'edited'
					};
				} else {
					this.edited_contract_parts.push({
						part_id:this.user_contract_parts[i].id,
						body:this.user_contract_parts[i].body,
						title:this.user_contract_parts[i].title,
						new_body:this.selectedPart.body,
						new_title:this.selectedPart.title,
						contract_id:this.id,
						type:'edited'
					});
				}
				this.user_contract_parts[i].tmp_edited = 1;
			}
			
			this.user_contract_parts[i].title = this.selectedPart.title;
			this.user_contract_parts[i].body = this.selectedPart.body;
			
			this.modificationCounter = this.modificationCounter + 1;
			this.showProperButton();
		
		}
		this.editFormVisible = false;		
	}
	
	onExpire(data){
		this.captchaSolved = false;
	}
	showResponse(data){
		this.captchaSolved = true;
	}
	
	validatePIN(){
		this.contractPinError = "";
		if(this.contractPin != ""){
			if(this.contractPin == this.contract.pin){				
				return true;
			} else {
				this.contractPinError = "Wrong contract PIN";
				return false;
			}		
		} else {
			this.contractPinError = "Please enter contract PIN";
			return false;
		}
	}
}