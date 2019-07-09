import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ContractService } from '../contract.service';
import { UserService } from '../../user/user.service';

import { Contract } from '../contract';
import { Message, SelectItem } from 'primeng/api';
import { AuthService } from '../../auth/auth.service';
import { MessageService } from 'primeng/components/common/messageservice';
import { Location} from '@angular/common';


@Component({
  selector: 'app-access-contract',
  templateUrl: './access-contract.component.html',
  styleUrls: ['./access-contract.component.css']
})
export class AccessContractComponent implements OnInit {
@ViewChild('documentsChild') documentsChild;
	id: number;
	token: string;
	msgs: Message[] = [];
	loggedInUser: any;
	loadSpinner: boolean = false;
	
	senderActive: boolean = false;
	contract: Contract;
	user_contract_parts: any[];
	contractLog: any;
	linkExpired: boolean = true;
	contractPinModel: boolean = false;
	contractPin: any = "";
	contractPinError: any = "";
	
	passwordModel: boolean = false;
	password: any = "";
	passwordError: any = "";
	passwordSuccess: any = "";

	constructor(aroute: ActivatedRoute, private router: Router, private contractService: ContractService, private auth: AuthService, private _location: Location, private messageService: MessageService, private userService: UserService) {
		aroute.params.subscribe(params => {
			this.token = params['token'];
			this.loadSpinner = true;
		});
	}

	ngOnInit() {
		this.loggedInUser = this.auth.getAuth();
		if(this.token != '' ){
			this.loadContract();			
		}		
	}
	
	loadContract() {
		this.contractService.getContractByToken(this.token).subscribe(res => {	
			this.contract = res;
			if(this.loggedInUser == null || (this.contract.receiver_id == this.loggedInUser.id && this.contract.receiver_role == this.loggedInUser.role)){
				if(this.checkTokenExpiration(this.contract.token_expiration)){
					this.linkExpired = false;
					this.contractPinModel = true;
					this.id = res.id;				
					this.user_contract_parts = res.get_contract_parts;				
				} else {
					this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Access Denied', detail: 'Contract Link expired.'});
					this.loadSpinner = false;
				}
			} else {
				this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Access Denied', detail: 'You dont have permission.'});
				this.loadSpinner = false;
			}
			
		});
	}
	
	loadContractLog() {
		this.contractService.getContractLog(this.id).subscribe(res => {	
			this.contractLog = res.contract;
		});
	}
	
	goBack() {
        this._location.back();
    }
	
	checkTokenExpiration(expiration) {
		let current = new Date()
		if(current < expiration){
			return true;
		}else{
			return false;
		}
    }
	
	validatePIN(){
		this.contractPinError = "";
		if(this.contractPin != ""){
			if(this.contractPin == this.contract.pin){		
				this.loadSpinner = false;
				this.contractPinModel = false;	
			} else {
				this.contractPinError = "Wrong contract PIN";
			}
		} else {
			this.contractPinError = "Please enter contract PIN";
		}
	
	}
	
	showPasswordBox(){
		this.passwordModel = true;
	}	
	
	setPassword(){
		this.passwordError = "";
		this.passwordSuccess = "";
		if(this.password != ""){
			this.userService.changePassword(this.contract.get_receiver_data.id, '', this.password).subscribe(res => {
				this.password = '';
				this.passwordSuccess = "Password saved successfully. Redirecting...";	
				setTimeout(()=>{
					  this.router.navigateByUrl('login');
				 }, 3000);				
			});
		} else {
			this.passwordError = "Please enter password";
		}
	
	}
}