import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ContractService } from '../contract.service';

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

	constructor(aroute: ActivatedRoute, private router: Router, private contractService: ContractService, private auth: AuthService, private _location: Location, private messageService: MessageService) {
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
			if(this.checkTokenExpiration(this.contract.token_expiration)){
				this.linkExpired = false;
				this.contractPinModel = true;
				this.id = res.id;				
				this.user_contract_parts = res.get_contract_parts;				
			} else {
				this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Access Denied', detail: 'Contract Link expired.'});
				this.loadSpinner = false;
			}
		});
	}
	
	loadContractLog() {
		this.contractService.getContractLog(this.id).subscribe(res => {	
			this.contractLog = res.contract;
			console.log(this.contractLog);
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
}