import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../auth/auth.service';
import { ConfigServiceService } from '../config-service.service';
import { Part } from './part';
import { PartChangeResponse } from './part-change-response';

@Injectable()
export class PartService {

  readonly apiUrl;

  constructor(private http: HttpClient, private auth: AuthService, config: ConfigServiceService) {
    this.apiUrl = config.getApiUrl();
  }

  getGlobalParts() {
    const token = this.auth.getToken();
    return this.http.get<Part[]>(this.apiUrl + '/contract-part/global', {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }
  
  getParts() {
    const token = this.auth.getToken();
    return this.http.get<Part[]>(this.apiUrl + '/contract-part', {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }
  
  getPart(id: number) {
    const token = this.auth.getToken();
    return this.http.get<Part>(this.apiUrl + '/contract-part/' + id, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    }).map(res => {
      return new Part(res);
    });
  } 
   savePart(id: number, data: Part) {
    const token = this.auth.getToken();
	if(id > 0 ){
		return this.http.put<PartChangeResponse>(this.apiUrl + '/contract-part/' + id, data, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
	} else {
		return this.http.post<PartChangeResponse>(this.apiUrl + '/contract-part', data, {
			headers: {
				Authorization: 'Bearer ' + token
			}
		});
	}
  }
  
  disablePart(id: number) {
    const token = this.auth.getToken();
    return this.http.post<PartChangeResponse>(this.apiUrl + '/part/disable-part/' + id, null, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }

  enablePart(id: number) {
    const token = this.auth.getToken();
    return this.http.post<PartChangeResponse>(this.apiUrl + '/part/enable-part/' + id, null, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  } 
  
}