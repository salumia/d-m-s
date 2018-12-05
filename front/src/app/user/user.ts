/* import { Leave } from './leave'; */
export class User {
  id: number;
  first_name: string;
  last_name: string;
  email: string;
  role: string;

  department: number;
  designation: string;
  father_name: string;
  mother_name: string;
  phone: string;
  alt_phone: string;
  correspondence_address: string;
  permanent_address: string;
  password: string;
  documents: any;
  /* leaves: Leave[]; */

  api_token_expires: Date;
  created_at: Date;
  updated_at: Date;

  isLoggedIn: boolean;

  constructor(data: any) {
    console.log(data);

    // Set normal fields
    this.id = data.id;
    this.first_name = data.first_name;
    this.last_name = data.last_name;
    this.email = data.email;
    this.role = data.role;
	
	this.department = data.department;
	this.designation = data.designation;
	this.father_name= data.father_name; 
	this.mother_name= data.mother_name;
	this.phone= data.phone;
	this.alt_phone= data.alt_phone;
	this.correspondence_address= data.correspondence_address;
	this.permanent_address= data.permanent_address;
	this.password= data.password;
	
	this.documents  = data.get_files;
/* 	this.leaves  = data.get_leaves; */

    // Parse date fields
    this.api_token_expires = new Date(Date.parse(data.api_token_expires));
    this.created_at = new Date(Date.parse(data.created_at));
    this.updated_at = new Date(Date.parse(data.updated_at));

    // Parse other fields
    this.isLoggedIn = this.api_token_expires.getTime() > Date.now();
  }
}
