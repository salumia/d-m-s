import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../auth/auth.service';
import { ConfigServiceService } from '../config-service.service';
import { User } from './user';
import { Vendor } from './vendor';
import { Admin } from './admin';
import { UserChangeResponse } from './user-change-response';
import { VendorChangeResponse } from './vendor-change-response';
import { AdminChangeResponse } from './admin-change-response';

@Injectable()
export class UserService {

  readonly apiUrl;

  constructor(private http: HttpClient, private auth: AuthService, config: ConfigServiceService) {
    this.apiUrl = config.getApiUrl();
  }

  getVendors() {
    const token = this.auth.getToken();
    return this.http.get<Vendor[]>(this.apiUrl + '/vendors', {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }
  getUsers() {
    const token = this.auth.getToken();
    return this.http.get<User[]>(this.apiUrl + '/users', {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }
  getAdmin(id: number) {
    const token = this.auth.getToken();
    return this.http.get<Admin>(this.apiUrl + '/admin/' + id, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    }).map(res => {
      return new Admin(res);
    });
  }  
  getVendor(id: number) {
    const token = this.auth.getToken();
    return this.http.get<Vendor>(this.apiUrl + '/vendors/' + id, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    }).map(res => {
      return new Vendor(res);
    });
  }  
  getUser(id: number) {
    const token = this.auth.getToken();
    return this.http.get<User>(this.apiUrl + '/users/' + id, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    }).map(res => {
      return new User(res);
    });
  }
  
  saveVendor(id: number, data: Vendor) {
    const token = this.auth.getToken();
	  if(id > 0 ){
		return this.http.put<VendorChangeResponse>(this.apiUrl + '/vendors/' + id, data, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
	} else {
		return this.http.post<VendorChangeResponse>(this.apiUrl + '/vendors', data, {
			headers: {
				Authorization: 'Bearer ' + token
			}
		});
	  }
  }
  
  saveAdmin(id: number, data: Admin) {
    const token = this.auth.getToken();
	  if(id > 0 ){
		return this.http.put<AdminChangeResponse>(this.apiUrl + '/admin/' + id, data, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
	} else {
		return this.http.post<AdminChangeResponse>(this.apiUrl + '/admin', data, {
			headers: {
				Authorization: 'Bearer ' + token
			}
		});
	  }
  }
  saveUser(id: number, data: User) {
    const token = this.auth.getToken();
	if(id > 0 ){
		return this.http.put<UserChangeResponse>(this.apiUrl + '/users/' + id, data, {
		  headers: {
			Authorization: 'Bearer ' + token
		  }
		});
	} else {
		return this.http.post<UserChangeResponse>(this.apiUrl + '/users', data, {
			headers: {
				Authorization: 'Bearer ' + token
			}
		});
	}
  }

  changePassword(id: number, my_password: string, new_password: string, role = 'users' ) {
    const token = this.auth.getToken();
    return this.http.post<UserChangeResponse>(this.apiUrl + '/' + role +  '/change-password/' + id, {
      my_password: my_password,
      new_password: new_password
    }, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }

  logoutUser(id: number) {
    const token = this.auth.getToken();
    return this.http.post<UserChangeResponse>(this.apiUrl + '/users/logout-user/' + id, null, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }

  disableUser(id: number, role = 'users') {
    const token = this.auth.getToken();
    return this.http.post<UserChangeResponse>(this.apiUrl + '/'+ role +'/disable-user/' + id, null, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  }

  enableUser(id: number, role = 'users') {
    const token = this.auth.getToken();
    return this.http.post<UserChangeResponse>(this.apiUrl + '/'+ role +'/enable-user/' + id, null, {
      headers: {
        Authorization: 'Bearer ' + token
      }
    });
  } 
  
  isEmailRegisterd(email: string, id: number = 0, role:string = 'user') {
        const token = this.auth.getToken();
        return this.http.post<any>(this.apiUrl + '/users/checkEmail', { email: email, id: id, role: role}, {
              /*   headers: {
                    Authorization: 'Bearer ' + token
                } */
            });
    }  
	
	checkDepartmentHOD(department, designation: string, id: number = 0) {
        const token = this.auth.getToken();
        return this.http.post<any>(this.apiUrl + '/users/checkDepartmentHOD', { department: department, designation: designation, id: id}, {
                headers: {
                    Authorization: 'Bearer ' + token
                }
            });
    }
	
	updateDocs(id:number,data:any) {		
        const token = this.auth.getToken();
        return this.http.post<any>(this.apiUrl + '/user/updatepagedocs',{'id':id,'files':data}, {
            headers: {
                Authorization: 'Bearer ' + token
            }
        });
    }
	
	deleteFile(id:number,data:any) {		
        const token = this.auth.getToken();
        return this.http.post<any>(this.apiUrl + '/user/deletefile',{'id':id,'file':data}, {
            headers: {
                Authorization: 'Bearer ' + token
            }
        });
    }

}