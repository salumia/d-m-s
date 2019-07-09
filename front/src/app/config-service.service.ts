import { Injectable, Inject } from '@angular/core';

@Injectable()
export class ConfigServiceService {

  private apiUrl = 'http://clerk.mybackpocket.io/api/public/api';
  private baseUrl = 'http://clerk.mybackpocket.io/api/public';

  constructor() {
    if (window.location.host.startsWith('localhost')) {
      this.apiUrl = 'http://localhost:8000/api';
      this.baseUrl = 'http://localhost:8000';
    }
  }

  getApiUrl() {
    return this.apiUrl;
  }  
  
  getBaseUrl() {
    return this.baseUrl;
  }

}
