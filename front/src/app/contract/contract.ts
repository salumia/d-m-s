export class Contract {
	id: number;
	industry_id: number;
	category_id: number;
	sender_id: number;
	receiver_id: number;
	receiver_email: number;
	sender_flag: number;
	receiver_flag: number;
	status: number;
	
	created_at: Date;
	updated_at: Date;
	
	constructor(data: any) {
		// Set normal fields
		this.id = data.id;
		this.industry_id = data.industry_id;
		this.category_id = data.category_id;
		this.sender_id = data.sender_id;
		this.receiver_id = data.receiver_id;
		this.receiver_email = data.receiver_email;
		this.sender_flag = data.sender_flag;
		this.receiver_flag = data.receiver_flag;
		this.status = data.status;
		
		this.created_at = new Date(Date.parse(data.created_at));
		this.updated_at = new Date(Date.parse(data.updated_at));
	}
}
