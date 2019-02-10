import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../auth/auth.service';
import { ConfigServiceService } from '../config-service.service';
import { Contract } from './contract';
import { ContractChangeResponse } from './contract-change-response';

@Injectable()
export class ContractService {

  readonly apiUrl;

  constructor(private http: HttpClient, private auth: AuthService, config: ConfigServiceService) {
    this.apiUrl = config.getApiUrl();
  }
  
   saveContract(id: number, data: Contract) {
    const token = this.auth.getToken();
	if(id > 0 ){
		return this.http.put<ContractChangeResponse>(this.apiUrl + '/contract/' + id, data, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
	} else {
		return this.http.post<ContractChangeResponse>(this.apiUrl + '/contract', data, {
			headers: {
				Authorization: 'Bearer ' + token
			}
		});
	}
  }
  
}