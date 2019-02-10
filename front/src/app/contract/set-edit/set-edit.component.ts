import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PartService } from '../part.service';
import { SetService } from '../set.service';
import { Set } from '../set';
import { Part } from '../part';
import { Message, SelectItem } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { AuthService } from '../../auth/auth.service';
import { MessageService } from 'primeng/components/common/messageservice';
import { Location} from '@angular/common';

@Component({
  selector: 'app-set-edit',
  templateUrl: './set-edit.component.html',
  styleUrls: ['./set-edit.component.css']
})
export class SetEditComponent implements OnInit {
	@ViewChild('documentsChild') documentsChild;
	id: number = 0;
	set: any = {};
	msgs: Message[] = [];
	setform: FormGroup;
	loadComponents: boolean = false;
	loggedInUser: any;
	loadSpinner: boolean = true;
	
	sourceParts: Part[];
    
    selectedParts: Part[];

	constructor(aroute: ActivatedRoute, private router: Router, private setService: SetService, private partService: PartService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location) {
		aroute.params.subscribe(params => {
			this.id = params['id'];
		});
	}

	ngOnInit() {
		this.loggedInUser = this.auth.getAuth();		
		this.setform = this.fb.group({
			'user_id': new FormControl('', Validators.required),
			'title': new FormControl('', Validators.required)
		});
		this.set.user_id = this.loggedInUser.id;
				
		this.partService.getAvailableParts(this.loggedInUser.id, this.id).subscribe(
			res => {
				this.sourceParts = res;
				this.loadSpinner = false;
			}
		);
		this.selectedParts = [];
		if(this.id > 0 ){
			this.loadTermSet();
		}
	}
  
	loadTermSet() {
		// Load Part
		this.setService.getPartSet(this.id).subscribe(res => {
			this.set = res;
			this.getTerms();
			this.loadSpinner = false;
		});

	}
	
	getTerms(){
		this.setService.getTerms(this.id).subscribe(res => {
		  this.selectedParts = res;
		  console.log(this.selectedParts);
		});
	}
  
	saveSet() {
		this.setService.saveSet(this.id, this.set).subscribe(res => {
			if(res.sets.id > 0){
				this.setService.saveSetTerms(res.sets.id, this.selectedParts).subscribe(res => {
					this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: res.message});
					setTimeout(() => {
						this.router.navigate(['sets']);
					}, 2000);
				});
			} else {
				this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: "Something went wrong."});
			}		
		});
	}
	
	goBack() {
        this._location.back();
    }

}
