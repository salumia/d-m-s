import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from '../auth.service';
import { Auth,ResetEmail } from '../auth';
import { AuthData } from '../auth-response';
import { Message } from 'primeng/components/common/api';
import { HttpErrorResponse } from '@angular/common/http';
import { TemplateConfigService } from '../../template/template-config.service';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';

@Component({
  selector: 'app-reset-password',
  templateUrl: './reset-password.component.html',
  styleUrls: ['./reset-password.component.css']
})
export class ResetPasswordComponent implements OnInit {
	public token: string;	
	public submitBtnEnable: boolean = false;
	public show: boolean = true;

	resetPasswordForm: FormGroup;
	
	public email: string;
	public password: string;
	
	public msgs: Message[];
  
	@Output() onFilter: any = new EventEmitter();
	constructor(aroute: ActivatedRoute, private auth: AuthService, private router: Router, private templateService: TemplateConfigService,  private fb: FormBuilder) {
		aroute.params.subscribe(params => {
			this.token = params['token'];
			this.verifyToken();
		});
	}

	ngOnInit() {
		
		this.resetPasswordForm = this.fb.group({
			'password': new FormControl('', Validators.required),		
		});
		
		if(this.auth.isLoggedIn()){
			this.templateService.filter('header refresh');
			this.router.navigate(['dashboard']);
		} else {
			//this.verifyToken();
		}
	}
	
	verifyToken(){		
		this.auth.getTokenData(this.token).subscribe(res => {
			if (res instanceof HttpErrorResponse) {
				this.updateMessage('Note:', res.error.message);
			} else if(typeof res.message != 'undefined') {
				this.updateMessage('Login Failed:', res.message);
			} else {
				this.email = res.email;
				this.submitBtnEnable = true;
			}
		});
	}

	resetPassword() {
		this.auth.resetPassword({email:this.email, password:this.password, token:this.token}).subscribe(res => {
			if (res instanceof HttpErrorResponse) {
				this.updateMessage('Note:', res.error.message);
				this.clearForm();
			} else if(typeof res.message != 'undefined') {
				this.updateMessage('Error :', res.message);
				this.clearForm();
			} else {
				this.msgs = [];
				this.msgs.push({
				  severity: 'success',
				  summary: 'Sucess :',
				  detail: 'Password reset successfully',
				});
				this.show = false;
				this.clearForm();
			}
		});
	}

	private updateMessage(summary:string, detail:string) {
		this.msgs = [];
		this.msgs.push({
		  severity: 'error',
		  summary: summary,
		  detail: detail
		});
	}

	private clearForm() {
		this.password = '';
	}

}
