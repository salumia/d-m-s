import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../auth/auth.service';
import { UserService } from '../user.service';
import { Vendor } from '../vendor';
import { Message } from 'primeng/api';
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

	constructor(private userService: UserService, private authService: AuthService, private messageService: MessageService) {}

	ngOnInit() {
		this.cols = [
			{ field: 'email', header: 'Email' },
			{ field: 'first_name', header: 'Name' },
			{ field: 'last_name', header: '' }
		];
		  
		this.loadUsers();
		this.loggedInUser = this.authService.getAuth();
	}

	loadUsers() {
		this.userService.getVendors().subscribe(res => this.users = res);
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

}
