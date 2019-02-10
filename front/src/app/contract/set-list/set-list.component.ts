import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../auth/auth.service';
import { SetService } from '../set.service';
import { User } from '../../user/user';
import { Set } from '../set';
import { Message, SelectItem } from 'primeng/api';
import { MessageService } from 'primeng/components/common/messageservice';

@Component({
  selector: 'app-set-list',
  templateUrl: './set-list.component.html',
  styleUrls: ['./set-list.component.css']
})
  
export class SetListComponent implements OnInit {
	sets: Set[] = [];
	msgs: Message[] = [];
	loggedInUser: User;
	cols: any[];
	loadSpinner = true;
	statuses: SelectItem[];

	constructor(private authService: AuthService, private setService: SetService, private messageService: MessageService) {}

	
	ngOnInit() {
		this.cols = [
			/* { field: 'id', header: 'Id' }, */
			{ field: 'title', header: 'Title' },
			{ field: 'status', header: 'Status' }
		];
		this.statuses = [
            { label: 'Select Status', value: null },
            { label: 'Enabled', value: '1' },
            { label: 'Disabled', value: '0' }
        ];
		  
		this.loadSets();
		this.loggedInUser = this.authService.getAuth();
	}

	loadSets() {
		this.setService.getPartSets().subscribe(
			res => {
				this.sets = res;
				this.loadSpinner = false;
			}
		);
	}
	
	disableSet(id: number) {
		this.setService.disableSet(id).subscribe(res => {		
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Global Set Updated', detail: res.message});
			// Reload sets
			this.loadSets();
		});
	}

	enableSet(id) {
		this.setService.enableSet(id).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Global Set Updated', detail: res.message});

			// Reload sets
			this.loadSets();

		});
	}
}
