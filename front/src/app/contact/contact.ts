export class Contact {
	id: number;
	vendor_id: number;
	user_id: number;
	name: string;
	email: string;
	type: string;
	company: string;
	cc: string;
	status: number;
	created_at: Date;
	updated_at: Date;
	
	constructor(data: any) {
		// Set normal fields
		this.id = data.id;
		this.vendor_id = data.vendor_id;
		this.user_id = data.user_id;
		this.name = data.name;
		this.email = data.email;
		this.type = data.type;
		this.company = data.company;
		this.cc = data.cc;
		
		this.status = data.status;
		this.created_at = new Date(Date.parse(data.created_at));
		this.updated_at = new Date(Date.parse(data.updated_at));
	}
}
