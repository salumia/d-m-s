import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../auth/auth.service';
import { ConfigServiceService } from '../config-service.service';
import { Contact } from './contact';
import { ContactChangeResponse } from './contact-change-response';

@Injectable()
export class ContactService {

  readonly apiUrl;

  constructor(private http: HttpClient, private auth: AuthService, config: ConfigServiceService) {
    this.apiUrl = config.getApiUrl();
  }
  
  getContacts(id:number) {
    const token = this.auth.getToken();
    return this.http.get<Contact[]>(this.apiUrl + '/contact/user/'+id, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }
  
  getContactList(id:number){
	const token = this.auth.getToken();
	return this.http.get<any>(this.apiUrl + '/contact-list/'+id,{
	  headers: {
        Authorization: 'Bearer ' + token
      }
    });
  } 
  
  getContact(id: number) {
    const token = this.auth.getToken();
    return this.http.get<Contact>(this.apiUrl + '/contact/' + id, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    }).map(res => {
      return new Contact(res);
    });
  } 
  
   saveContact(vendor_id: number, data: any, id: number) {	    
		const token = this.auth.getToken();
		if(id > 0){
			return this.http.put<any>(this.apiUrl + '/contact/' + id, data, {
			  headers: {
				Authorization: 'Bearer ' + token
			  }
			});
		} else {
			data.vendor_id = vendor_id;
			return this.http.post<any>(this.apiUrl + '/contact', { data }, {
				headers: {
					Authorization: 'Bearer ' + token
				}
			});
		}
  }
  
  deleteContact(id: number) {
    const token = this.auth.getToken();
    return this.http.delete<ContactChangeResponse>(this.apiUrl + '/contact/' + id, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }
  
  disableContact(id: number) {
    const token = this.auth.getToken();
    return this.http.post<ContactChangeResponse>(this.apiUrl + '/contact/disable-contact/' + id, null, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }

  enableContact(id: number) {
    const token = this.auth.getToken();
    return this.http.post<ContactChangeResponse>(this.apiUrl + '/contact/enable-contact/' + id, null, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  } 
  
  
  emailSuggestions(id:number,query:string = 'a'){
	const token = this.auth.getToken();
	return this.http.get<any>(this.apiUrl + '/contact/suggestion/'+id+'/'+query ,{
	  headers: {
        Authorization: 'Bearer ' + token
      }
    });
  } 
  
  searchContactList(id:number,query:string = ''){
	const token = this.auth.getToken();
	return this.http.get<any>(this.apiUrl + '/contact/search/'+id+'/'+query ,{
	  headers: {
        Authorization: 'Bearer ' + token
      }
    });
  } 
  
}