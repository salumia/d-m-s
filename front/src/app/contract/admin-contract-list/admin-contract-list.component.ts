import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ContractService } from '../contract.service';
import { Contract } from '../contract';
import { User } from '../../user/user';
import { Message, SelectItem, ConfirmationService } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { AuthService } from '../../auth/auth.service';
import { MessageService } from 'primeng/components/common/messageservice';
import { Location} from '@angular/common';

@Component({
  selector: 'app-admin-contract-list',
  templateUrl: './admin-contract-list.component.html',
  styleUrls: ['./admin-contract-list.component.css']
})

export class AdminContractListComponent implements OnInit {
	contracts: Contract[] = [];
	msgs: Message[] = [];
	loggedInUser: User;
	cols: any[];
	loadSpinner = true;
	viewContractFlag: boolean = false;
	statuses: SelectItem[];

	constructor(private authService: AuthService, private contractService: ContractService, private messageService: MessageService, private confirmationService: ConfirmationService) {}

	ngOnInit() {
		this.loggedInUser = this.authService.getAuth();
		this.cols = [
			{ field: 'id', header: 'Contract ID' },
			{ field: 'name', header: 'Contract Name' },
			{ field: 'get_sender_data.email', header: 'Owner' },
			{ field: 'email', header: 'Recipient' },
			{ field: 'status', header: 'Status' },
			{ field: 'updated_at', header: 'Last Update' }
		];
		this.statuses = [
            { label: 'Select Status', value: null },
            { label: 'Draft', value: '0' },
            { label: 'Under Review', value: '1' },
            { label: 'Finalized', value: '2' },
            { label: 'Rejected', value: '3' },
        ];
		  				
		this.loadContracts();
	}

	loadContracts() {
		this.contractService.loadAllContracts().subscribe(
			res => {
				this.contracts = res;
				this.loadSpinner = false;
			}
		);
	}
	
	openContract(id:number){
		this.confirmationService.confirm({
			message: 'Are you sure to open the contract',
            header: 'Contract State Confirmation',
            icon: 'pi pi-info-circle',
            accept: () => {
                this.contractService.openContract(id).subscribe(res => {
					this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Contract is back to open state.', detail: res.message});

					this.loadContracts();

				});
            }
        });
	}
	
	
}

