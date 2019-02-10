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
   saveContact(vendor_id: number, email: any) {
		const token = this.auth.getToken();
		return this.http.post<any>(this.apiUrl + '/contact', { vendor_id:vendor_id, email: email }, {
			headers: {
				Authorization: 'Bearer ' + token
			}
		});
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
  
}