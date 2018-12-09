import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../auth/auth.service';
import { UserService } from '../user.service';
import { MessageService } from 'primeng/components/common/messageservice';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';

@Component({
  selector: 'app-change-password',
  templateUrl: './change-password.component.html',
  styleUrls: ['./change-password.component.css']
})
export class ChangePasswordComponent implements OnInit {

  user: any;
  Userform: FormGroup;
  
  constructor(private userService: UserService, private auth: AuthService, private fb: FormBuilder, private messageService: MessageService) { }

	ngOnInit() {
		this.Userform = this.fb.group({        
			'new_password': new FormControl('', Validators.required),
			'confirm_password': new FormControl('', Validators.compose([Validators.required]),this.isMatched.bind(this))
		});
		this.user = this.auth.getAuth();
	}
  
	isMatched(control: FormControl) {
		let newPassword = this.Userform.controls['new_password'].value;
		const q = new Promise((resolve, reject) => {
            if(newPassword == control.value){
				resolve(null);
			} else {
				resolve({ 'isMatched': true });
			}
        });
		return q;
    }	
	
	doPasswordChange(data) {
		this.userService.changePassword(this.user.id, '', data.new_password).subscribe(res => {
			this.Userform.reset();
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: 'Password updated successfully'});		
		});
	}

}