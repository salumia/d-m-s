import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../auth/auth.service';
import { UserService } from '../user.service';
import { User } from '../user';
import { Message } from 'primeng/api';
import { MessageService } from 'primeng/components/common/messageservice';

@Component({
  selector: 'app-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css']
})
export class UserListComponent implements OnInit {
	users: User[];
	passwordDialogVisible = false;
	selectedUser: User;
	myPassword: string;
	newPassword: string;
	msgs: Message[] = [];
	loggedInUser: User;
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
		this.userService.getUsers().subscribe(res => this.users = res);
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
		this.userService.changePassword(this.selectedUser.id, this.myPassword, this.newPassword).subscribe(res => {
			// Clear fields
			this.myPassword = '';
			this.newPassword = '';
			// Close dialog
			this.passwordDialogVisible = false;
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Password Updated', detail: res.message});   
		});
	}

	disableUser(id: number) {
		this.userService.disableUser(id).subscribe(res => {		
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'User Updated', detail: res.message});
			// Reload Users
			this.loadUsers();
		});
	}

	enableUser(id) {
		this.userService.enableUser(id).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'User Updated', detail: res.message});

			// Reload Users
			this.loadUsers();

		});
	}

}
