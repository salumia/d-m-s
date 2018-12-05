export class AuthResponse {

  data: AuthData;

}

export class AuthData {

  id: number;
  first_name: string;
  last_name: string;
  email: string;
  role: string;
  department: number;
  designation: string;
  api_token: string;
  api_token_expires: string;

  constructor(data: any) {
    this.id = data.id;
    this.first_name = data.first_name;
    this.last_name = data.last_name;
    this.email = data.email;
    this.role = data.role;
    this.department = data.department;
    this.designation = data.designation;
    this.api_token = data.api_token;
    this.api_token_expires = data.api_token_expires;
  }

}
