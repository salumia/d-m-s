import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../auth/auth.service';
import { IndustryService } from '../../industry.service';
import { User } from '../../../user/user';
import { Industry } from '../../industry';
import { Message } from 'primeng/api';
import { MessageService } from 'primeng/components/common/messageservice';

@Component({
  selector: 'app-industry-list',
  templateUrl: './industry-list.component.html',
  styleUrls: ['./industry-list.component.css']
})
  
export class IndustryListComponent implements OnInit {
	industries: Industry[] = [];
	msgs: Message[] = [];
	loggedInUser: User;
	cols: any[];

	constructor(private authService: AuthService, private industryService: IndustryService, private messageService: MessageService) {}

	ngOnInit() {
		this.cols = [
			{ field: 'id', header: 'Id' },
			{ field: 'name', header: 'Name' }
		];
		  
		this.loadIndustries();
		this.loggedInUser = this.authService.getAuth();
	}

	loadIndustries() {
		this.industryService.getIndustries().subscribe(res => this.industries = res);
	}
	
	disableIndustry(id: number) {
		this.industryService.disableIndustry(id).subscribe(res => {		
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Industry Updated', detail: res.message});
			// Reload industries
			this.loadIndustries();
		});
	}

	enableIndustry(id) {
		this.industryService.enableIndustry(id).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Industry Updated', detail: res.message});

			// Reload industries
			this.loadIndustries();

		});
	}
}
