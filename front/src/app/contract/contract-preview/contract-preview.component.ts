import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ContractService } from '../contract.service';

import { Contract } from '../contract';
import { Message, SelectItem } from 'primeng/api';
import { AuthService } from '../../auth/auth.service';
import { Location} from '@angular/common';
import { MessageService } from 'primeng/components/common/messageservice';
import { ConfigServiceService } from '../../config-service.service';

@Component({
  selector: 'app-contract-preview',
  templateUrl: './contract-preview.component.html',
  styleUrls: ['./contract-preview.component.css']
})

export class ContractPreviewComponent implements OnInit {
@ViewChild('documentsChild') documentsChild;
	id: number;
	msgs: Message[] = [];
	loggedInUser: any;
	loadSpinner: boolean = false;
	apiUrl: any;
	
	senderActive: boolean = false;
	contract: Contract;
	user_contract_parts: any[];
	contractLog: any;

	constructor(aroute: ActivatedRoute, private router: Router, private contractService: ContractService, private auth: AuthService, private _location: Location,  config: ConfigServiceService, private messageService: MessageService) {
		this.apiUrl = config.getApiUrl();
		aroute.params.subscribe(params => {
			this.id = params['id'];
			this.loadSpinner = true;
		});
	}

	ngOnInit() {
		this.loggedInUser = this.auth.getAuth();
		if(this.id > 0 ){
			this.loadContract();
			this.loadContractLog();
		}		
	}
	
	loadContract() {
		this.contractService.getContract(this.id).subscribe(res => {	
			this.contract = res;		
			this.setUserType();			
			this.user_contract_parts = res.get_contract_parts;
			this.loadSpinner = false;
			this.updateNotifications()
			console.log(this.user_contract_parts);
		});
	}
	
	loadContractLog() {
		this.contractService.getContractLog(this.id).subscribe(res => {	
			this.contractLog = res.contract;
			console.log(this.contractLog);
		});
	}
	
	updateNotifications(){
		this.contractService.updateNotifications(this.loggedInUser.id, this.loggedInUser.role, this.id, 'preview').subscribe(res => {	
			
		});
	}
	
	setUserType(){
		if(this.contract.receiver_id == this.loggedInUser.id && this.loggedInUser.role == this.contract.receiver_role ){
			this.senderActive = false;
		} else {
			this.senderActive = true;
		}	
		console.log("senderActive");
		console.log(this.senderActive);
	}
	
	goBack() {
        this._location.back();
    }
	
	printPreview(){
		let contractUrl = this.apiUrl + '/contract/' + this.id + '/print';
		let printContent = document.getElementById("tab01").innerHTML;
		let originalContents = document.body.innerHTML;
		let WindowPrt = window.open(contractUrl, '', 'left=0,top=0,width=700,height=auto');
		WindowPrt.focus();
		WindowPrt.print();
		WindowPrt.close();
	}
	
	sendEmail(){
		this.contractService.sendContractAttachment(this.id, this.senderActive).subscribe(res => {	
			if(res.statusCode == 200){
				this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: res.message});
			} else {
				this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: res.message});
			}
		});
	}
}