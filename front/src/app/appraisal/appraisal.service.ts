import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../auth/auth.service';
import { ConfigServiceService } from '../config-service.service';
import { Appraisal } from './appraisal';

@Injectable()
export class AppraisalService {

	readonly apiUrl;

	constructor(private http: HttpClient, private auth: AuthService, config: ConfigServiceService) {
		this.apiUrl = config.getApiUrl();
	}

	getUsersList(user_id) {
		const token = this.auth.getToken();
		return this.http.post<any>(this.apiUrl + '/users-list',{'user_id':user_id}, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
	}  
	
	sendAppraisalForm(id: number, data: any) {
		const token = this.auth.getToken();
		if(id > 0 ){
			return this.http.put<any>(this.apiUrl + '/appraisal/' + id, data, {
			  headers: {
				Authorization: 'Bearer ' + token
			  }
			});
		} else {
			data.status = 'Pending';
			return this.http.post<any>(this.apiUrl + '/appraisal', data, {
				headers: {
					Authorization: 'Bearer ' + token
				}
			});
		}
	}

	getAppraisal(id:number) {
		const token = this.auth.getToken();
		return this.http.get<Appraisal>(this.apiUrl + '/appraisal/'+id, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
    }	
	
	getAllAppraisalPoints() {
		const token = this.auth.getToken();
		return this.http.get<any>(this.apiUrl + '/appraisal-points', {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
    }
		
	getAllAppraisals(user_id, department) {
		const token = this.auth.getToken();
		return this.http.get<Appraisal[]>(this.apiUrl + '/appraisal?u_id='+user_id+'&dep='+department, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
    }
	
	getAppraisalForm(id:number){
		const token = this.auth.getToken();
		return this.http.get<Appraisal>(this.apiUrl + '/appraisal/'+id, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
	}
	
	saveFeedback(data: any, appraisal_id:number, action){
		const token = this.auth.getToken();
		if(action == 'insert'){
			return this.http.post<any>(this.apiUrl + '/appraisal/save-feedback/' + appraisal_id, data, 
				{
					headers: {
						Authorization: 'Bearer ' + token
					}
				});
		} else {
			return this.http.post<any>(this.apiUrl + '/appraisal/update-feedback', data, {
					headers: {
						Authorization: 'Bearer ' + token
					}
				});
		}
	}
	
	saveKeyResponsibility(data: any){
		const token = this.auth.getToken();
		return this.http.post<any>(this.apiUrl + '/appraisal/update-key-responsibility', data, {
					headers: {
						Authorization: 'Bearer ' + token
					}
				});
	}
	
	getActiveAppraisal(user_id : number){
		const token = this.auth.getToken();
		return this.http.post<any>(this.apiUrl + '/appraisal/get-active-appraisal',{'user_id':user_id}, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
	}
	
	getReviewAppraisalList(user_id : number){
		const token = this.auth.getToken();
		return this.http.post<any>(this.apiUrl + '/appraisal/get-review-appraisals',{'user_id':user_id}, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
	}	
	
	getDepartmentAppraisalList(department : number){
		const token = this.auth.getToken();
		return this.http.post<any>(this.apiUrl + '/appraisal/get-department-appraisals',{'department':department}, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
	}
	
	saveResponsibility(data: any){
		const token = this.auth.getToken();
		return this.http.post<any>(this.apiUrl + '/appraisal/save-key-responsibilities/', data, 
			{
				headers: {
					Authorization: 'Bearer ' + token
				}
			});
		
	}
	
	deleteResponsibility(id:number){
		const token = this.auth.getToken();
		return this.http.post<any>(this.apiUrl + '/appraisal/delete-responsibility/', {'id':id}, 
			{
				headers: {
					Authorization: 'Bearer ' + token
				}
			});
	}

}
