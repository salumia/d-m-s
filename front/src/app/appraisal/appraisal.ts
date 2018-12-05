export class Appraisal {
  id: number;
  from_date: any;
  to_date: any;
  status: string;
  user_id: number;
  reviewer_id: number;
  staff_comments: string;
  reviewer_comments: string;
  
  user_data:any;
  reviewer_data:any;
  feedback_data:any;
  key_responsibility_data:any;
  
  created_at: Date;
  updated_at: Date;

  constructor(data: any) {
	// Set normal fields
    this.id = data.id;
    this.from_date = new Date(Date.parse(data.from_date));
    this.to_date = new Date(Date.parse(data.to_date));
	this.status= data.status;
	this.user_id= data.user_id;
	this.reviewer_id= data.reviewer_id;
	
	this.staff_comments= data.staff_comments;
	this.reviewer_comments= data.reviewer_comments;
	
	this.user_data  = data.get_user_data;
	this.reviewer_data  = data.get_reviewer_data;
	this.feedback_data  = data.get_feedback_data;
	this.key_responsibility_data  = data.get_key_responsibility_data;
		
    this.created_at = new Date(Date.parse(data.created_at));
    this.updated_at = new Date(Date.parse(data.updated_at));
  }
}


