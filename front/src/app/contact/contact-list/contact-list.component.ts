import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from '../../auth/auth.service';
import { ContactService } from '../contact.service';
import { User } from '../../user/user';
import { Contact } from '../contact';
import { Message,SelectItem, ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/components/common/messageservice';
import { UserService } from '../../user/user.service';

@Component({
  selector: 'app-contact-list',
  templateUrl: './contact-list.component.html',
  styleUrls: ['./contact-list.component.css']
})

export class ContactListComponent implements OnInit {
	contacts: Contact[] = [];
	msgs: Message[] = [];
	selectedUser: any = 0;
	selectedUserName: any = '';
	loggedInUser: User;
	cols: any[];	
	contactViewVisible = false;
	addContactVisible = false;	
	selectedContact: Contact;
	newContactEmail:any = "";
	loadSpinner = true;
	statuses: SelectItem[];

	constructor(aroute: ActivatedRoute, private router: Router, private authService: AuthService, private contactService: ContactService, private messageService: MessageService, private confirmationService: ConfirmationService,private userService: UserService,) {
		aroute.params.subscribe(params => {
			if(typeof params['user'] != "undefined"){
				this.selectedUser = params['user'];
			}
		});			
	}

	ngOnInit() {
		this.loggedInUser = this.authService.getAuth();
		this.cols = [
			{ field: 'company', header: 'Company Name' },
			{ field: 'name', header: 'Contact Name' },
			{ field: 'email', header: 'Email' },
			{ field: 'status', header: 'Status' }
		];		

		this.statuses = [
            { label: 'Select Status', value: null },
            { label: 'Enabled', value: '1' },
            { label: 'Disabled', value: '0' }
        ];  	
		
		this.loadUserContacts();
	}

	loadUserContacts() {
		if(this.selectedUser > 0){
			this.contactService.getContacts(this.selectedUser).subscribe(res => {
				this.loadSpinner = false;
				this.contacts = res;
			});
			this.userService.getVendor(this.selectedUser).subscribe(res => {
			  this.selectedUserName = res.name;
			});
		} else {
			this.contactService.getContacts(this.loggedInUser.id).subscribe(res => {
				this.loadSpinner = false;
				this.contacts = res;
			});
		}
	}
	
	deleteContact(id: number) {
		this.confirmationService.confirm({
			message: 'Do you want to delete this record?',
            header: 'Delete Confirmation',
            icon: 'pi pi-info-circle',
            accept: () => {
                this.contactService.deleteContact(id).subscribe(res => {		
					this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Contact Deleted', detail: res.message});
					// Reload Contacts
					this.loadUserContacts();
				});
            }
        });
	}
	
	disableContact(id: number) {
		this.contactService.disableContact(id).subscribe(res => {		
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Contact Updated', detail: res.message});
			// Reload Contacts
			this.loadUserContacts();
		});
	}

	enableContact(id) {
		this.contactService.enableContact(id).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Contact Updated', detail: res.message});

			// Reload Contacts
			this.loadUserContacts();

		});
	}
	
	viewContact(contact_id: number) {
		for (const contact of this.contacts) {
		  if (contact.id === contact_id) {
			this.selectedContact = contact;
		  }
		}
		this.contactViewVisible = true;
	}
	
	showAddContactDialog() {
		this.addContactVisible = true;
	}

	// Adding missing method 
	saveContact(){
		
	}
}
