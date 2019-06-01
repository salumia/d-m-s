import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ContractService } from '../contract.service';

import { Message, SelectItem, ConfirmationService } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { MessageService } from 'primeng/components/common/messageservice';
import { Location} from '@angular/common';

@Component({
  selector: 'app-contract-setting',
  templateUrl: './contract-setting.component.html',
  styleUrls: ['./contract-setting.component.css']
})
export class ContractSettingComponent implements OnInit {
	
	msgs: Message[] = [];
	loadSpinner: boolean = true;
	terms: string = '';
	contractTermsForm: FormGroup;
    
	constructor(private contractService: ContractService, private messageService: MessageService, private _location: Location,  private confirmationService: ConfirmationService, private fb: FormBuilder) { }

	ngOnInit() {
		this.contractTermsForm = this.fb.group({
			'terms': new FormControl('', Validators.required)
		});
		this.loadTermsOfService();
	}
  
	goBack() {
		this._location.back();
	}
	
	loadTermsOfService() {		
		this.contractService.getTermsOfService().subscribe(res => {
			this.terms = res.tos;
			this.loadSpinner = false;
		});
	}
	
	saveTermsOfService() {
		this.loadSpinner = true;		
		this.contractService.saveTermsOfService(this.terms).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: "Contract Terms Of Service updated successfully"});		
			this.loadSpinner = false;			
		});
	}
	

}
