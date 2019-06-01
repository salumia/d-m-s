import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { Router } from "@angular/router";
import { AuthService } from '../auth.service';
import { Auth,ResetEmail } from '../auth';
import { AuthData } from '../auth-response';
import { Message } from 'primeng/components/common/api';
import { HttpErrorResponse } from '@angular/common/http';
import { TemplateConfigService } from '../../template/template-config.service';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { MessageService } from 'primeng/components/common/messageservice';

@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html',
  styleUrls: ['./forgot-password.component.css']
})
export class ForgotPasswordComponent implements OnInit {
  public username: string;
  public password: string;
  public msgs: Message[];
  processing: boolean = false;
  Forgotform: FormGroup;
  
  @Output() onFilter: any = new EventEmitter();
  constructor(private auth: AuthService, private router: Router, private templateService: TemplateConfigService,private fb: FormBuilder, private messageService: MessageService) { }

  ngOnInit() {
    if(this.auth.isLoggedIn()){
		this.templateService.filter('header refresh');
		this.router.navigate(['dashboard']);
	}
	this.Forgotform = this.fb.group({	
		'username': new FormControl('', Validators.compose([Validators.required,Validators.email]))
	});
  }

  doAuth() {
	this.processing = true;
    const auth = this.username;
    this.auth.reset(auth).subscribe(res => {
		this.processing = false;
		if (res instanceof HttpErrorResponse) {
			if (res.error.statusCode == 404) {
				this.updateMessage('Note:', res.error.message);
				this.clearForm();
			} else if (res.error.statusCode == 200) {
				this.msgs = [];
				this.msgs.push({
				  severity: 'success',
				  summary: 'Success',
				  detail: res.error.message
				});
				this.clearForm();
			}
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
