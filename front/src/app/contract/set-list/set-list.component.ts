import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../auth/auth.service';
import { SetService } from '../set.service';
import { User } from '../../user/user';
import { Set } from '../set';
import { Message, SelectItem, ConfirmationService } from 'primeng/api';
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

	constructor(private authService: AuthService, private setService: SetService, private messageService: MessageService, private confirmationService: ConfirmationService) {}

	
	ngOnInit() {
		this.loggedInUser = this.authService.getAuth();
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
	}

	loadSets() {
		this.setService.getUserSets(this.loggedInUser.id).subscribe(
			res => {
				this.sets = res;
				this.loadSpinner = false;
			}
		);
	}
	
	disableSet(id: number) {
		this.setService.disableSet(id).subscribe(res => {		
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Set Updated', detail: res.message});
			// Reload sets
			this.loadSets();
		});
	}

	enableSet(id) {
		this.setService.enableSet(id).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Set Updated', detail: res.message});

			// Reload sets
			this.loadSets();

		});
	}
	
	deleteSet(id: number) {
		this.confirmationService.confirm({
			message: 'Do you want to delete this record?',
            header: 'Delete Confirmation',
            icon: 'pi pi-info-circle',
            accept: () => {
                this.setService.deleteSet(id).subscribe(res => {		
					this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Set Deleted', detail: res.message});
					// Reload Categories
					this.loadSets();
				});
            }
        });
	}
}
