import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../auth/auth.service';
import { PartService } from '../../part.service';
import { User } from '../../../user/user';
import { Part } from '../../part';
import { Message } from 'primeng/api';
import { MessageService } from 'primeng/components/common/messageservice';

@Component({
  selector: 'app-global-list',
  templateUrl: './global-list.component.html',
  styleUrls: ['./global-list.component.css']
})
  
export class GlobalListComponent implements OnInit {
	parts: Part[] = [];
	msgs: Message[] = [];
	loggedInUser: User;
	cols: any[];

	constructor(private authService: AuthService, private partService: PartService, private messageService: MessageService) {}

	
	ngOnInit() {
		this.cols = [
			{ field: 'title', header: 'Title' },
			{ field: 'internal_title', header: 'Internal Title' },
			{ field: 'get_industry_data.name', header: 'Industry' },
		];
		  
		this.loadGlobalParts();
		this.loggedInUser = this.authService.getAuth();
	}

	loadGlobalParts() {
		this.partService.getGlobalParts().subscribe(
			res => this.parts = res
		);
	}
	
	disablePart(id: number) {
		this.partService.disablePart(id).subscribe(res => {		
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Global Part Updated', detail: res.message});
			// Reload industries
			this.loadGlobalParts();
		});
	}

	enablePart(id) {
		this.partService.enablePart(id).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Global Part Updated', detail: res.message});

			// Reload industries
			this.loadGlobalParts();

		});
	}
}
