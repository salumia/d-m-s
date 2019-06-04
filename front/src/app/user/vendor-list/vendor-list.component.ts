import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../auth/auth.service';
import { UserService } from '../user.service';
import { Vendor } from '../vendor';
import { Message, SelectItem, ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/components/common/messageservice';

@Component({
  selector: 'app-vendor-list',
  templateUrl: './vendor-list.component.html',
  styleUrls: ['./vendor-list.component.css']
})
export class VendorListComponent implements OnInit {
	users: Vendor[];
	passwordDialogVisible = false;
	selectedUser: Vendor;
	myPassword: string;
	newPassword: string;
	msgs: Message[] = [];
	loggedInUser: Vendor;
	cols: any[];
	loadSpinner = true;
	statuses: SelectItem[];

	constructor(private userService: UserService, private authService: AuthService, private messageService: MessageService, private confirmationService: ConfirmationService) {}

	ngOnInit() {
		this.cols = [
			{ field: 'shop_name', header: 'Company Name' },
			{ field: 'name', header: 'Contact Name' },
			{ field: 'email', header: 'Contact Email' },
			{ field: 'role', header: 'Status' }
		];
		
		this.statuses = [
            { label: 'Status', value: null },
            { label: 'Enabled', value: 'vendor' },
            { label: 'Disabled', value: 'disabled' }
        ];
		  
		this.loadUsers();
		this.loggedInUser = this.authService.getAuth();
	}

	loadUsers() {
		this.userService.getVendors().subscribe(res => {				
				this.users = res;
				this.loadSpinner = false;
			}		
		);
	}

	changePassword(user_id: number) {
		for (const user of this.users) {
		  if (user.id === user_id) {
			this.selectedUser = user;
		  }
		}
		this.myPassword = '';
		this.newPassword = '';
		this.passwordDialogVisible = true;
	}

	doPasswordChange() {
		this.userService.changePassword(this.selectedUser.id, this.myPassword, this.newPassword, 'vendor').subscribe(res => {
			// Clear fields
			this.myPassword = '';
			this.newPassword = '';
			// Close dialog
			this.passwordDialogVisible = false;
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Password Updated', detail: res.message});   
		});
	}

	
	disableUser(id: number) {
		this.userService.disableUser(id,'vendor').subscribe(res => {		
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'User Updated', detail: res.message});
			// Reload Users
			this.loadUsers();
		});
	}

	enableUser(id) {
		this.userService.enableUser(id,'vendor').subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'User Updated', detail: res.message});

			// Reload Users
			this.loadUsers();

		});
	}
	
	deleteUser(id: number) {
		this.confirmationService.confirm({
			message: 'Are you sure ?',
            header: 'Delete Confirmation',
            icon: 'pi pi-info-circle',
            accept: () => {
                this.userService.deleteUser(id, 'vendors').subscribe(res => {
					if(res.statusCode == 202){
						this.messageService.add({key: 'top-corner', severity: 'error', summary: 'Error', detail: res.message});
					} else {
						this.messageService.add({key: 'top-corner', severity: 'success', summary: 'User Deleted', detail: res.message});
						// Reload Categories
						this.loadUsers();
					}
				});
            }
        });
	}

}
