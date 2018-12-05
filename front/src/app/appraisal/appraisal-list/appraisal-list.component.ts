import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../auth/auth.service';
import { AppraisalService } from '../appraisal.service';
import { User } from '../../user/user';
import { Appraisal } from '../appraisal';
import { Message } from 'primeng/api';
import { MessageService } from 'primeng/components/common/messageservice';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-appraisal-list',
  templateUrl: './appraisal-list.component.html',
  styleUrls: ['./appraisal-list.component.css']
})
export class AppraisalListComponent implements OnInit {

  appraisals: Appraisal[];
  msgs: Message[] = [];
  loggedInUser: User;
  cols: any[];
  sendAppraisalLink: boolean = false;
  
  constructor(private appraisalService: AppraisalService, private authService: AuthService, private messageService: MessageService) { }

	ngOnInit() {
		this.cols = [
			{ field: 'get_user_data.first_name', header: 'Employee' },
			{ field: 'get_user_data.last_name', header: '' },
			{ field: 'from_date', header: 'Period' },
			{ field: 'to_date', header: '' },
			
			{ field: 'get_reviewer_data.first_name', header: 'Reviewer' },
			{ field: 'get_reviewer_data.last_name', header: '' },
			{ field: 'created_at', header: 'Sent On' },
			{ field: 'status', header: 'Status' }
		];

		this.loggedInUser = this.authService.getAuth();
		this.loadappraisals();
	}
	
	
	loadappraisals() {
		console.log("loadappraisals");
		console.log(this.loggedInUser);
		
		
		if( this.loggedInUser.designation == "hod" ){
			this.appraisalService.getDepartmentAppraisalList(this.loggedInUser.department).subscribe(res => {			
				this.appraisals = res;
			}); 
		} else {
			this.appraisalService.getAllAppraisals(this.loggedInUser.id, this.loggedInUser.department).subscribe(res => {
				this.appraisals = res;
			});
		}
		
		if(this.loggedInUser.role == 'admin' || this.loggedInUser.department == 1){
			this.sendAppraisalLink = true;
		}
	}
	
}

