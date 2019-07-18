export class User {
  id: number;
  name: string;
  shop_name: string;
  gender: string;
  email: string;
  phone: number;
  fax: string;
  address: string;
  city: string;
  zip: string;
  password: string;

  api_token_expires: Date;
  created_at: Date;
  updated_at: Date;
  contact_added_by: any;
  username: string;
  role: string;

  isLoggedIn: boolean;

  constructor(data: any) {
    // Set normal fields
    this.id = data.id;
    this.name = data.name;
    this.shop_name = data.shop_name;
    this.gender = data.gender;
    this.email = data.email;
    this.phone = data.phone;
    this.fax = data.fax;
    this.address = data.address;
    this.city = data.city;
    this.zip = data.zip;    
	this.contact_added_by = data.contact_added_by;
	this.username = data.username;
	
    // Parse date fields
    this.api_token_expires = new Date(Date.parse(data.api_token_expires));
    this.created_at = new Date(Date.parse(data.created_at));
    this.updated_at = new Date(Date.parse(data.updated_at));

    // Parse other fields
    this.isLoggedIn = this.api_token_expires.getTime() > Date.now();
  }
}
