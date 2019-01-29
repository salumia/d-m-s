export class Part {
	id: number;
	title: string;
	internal_title: string;
	body: string;
	special: string;
	type: number;
	industry_id: number;
	status: number;
	
	industry_data:any;
	
	created_at: Date;
	updated_at: Date;
	
	constructor(data: any) {
		// Set normal fields
		this.id = data.id;
		this.title = data.title;
		this.internal_title = data.internal_title;
		this.body = data.body;
		this.type = data.type;
		this.industry_id = data.industry_id;
		this.status = data.status;
		console.log("data.get_industry_data");
		console.log(data.get_industry_data);
		this.industry_data = data.get_industry_data;
		
		this.created_at = new Date(Date.parse(data.created_at));
		this.updated_at = new Date(Date.parse(data.updated_at));
	}
}
