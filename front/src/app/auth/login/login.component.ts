import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { Router } from "@angular/router";
import { AuthService } from '../auth.service';
import { Auth } from '../auth';
import { AuthData } from '../auth-response';
import { Message } from 'primeng/components/common/api';
import { HttpErrorResponse } from '@angular/common/http';
import { TemplateConfigService } from '../../template/template-config.service';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { MessageService } from 'primeng/components/common/messageservice';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  public username:string;
  public password:string;
  public msgs: Message[];
  processing: boolean = false;
  
  Loginform: FormGroup;
  
  @Output() onFilter: any = new EventEmitter();
  constructor(private auth: AuthService, private router: Router, private templateService: TemplateConfigService, private fb: FormBuilder, private messageService: MessageService) { }

  ngOnInit() {
	
	
	  
    if(this.auth.isLoggedIn()){
		this.templateService.filter('header refresh');
		this.router.navigate(['dashboard']);
	}
	
	this.Loginform = this.fb.group({	
		'username': new FormControl('', Validators.compose([Validators.required,Validators.email])),
		'password': new FormControl('', Validators.required)
	});
	
  }

  doAuth() {
	this.msgs = [];
	this.processing = true;
    let auth: Auth = new Auth(this.username, this.password);

    this.auth.login(auth).subscribe(res => {
      this.processing = false;
	  this.clearForm();
      if(res instanceof HttpErrorResponse) {
        this.updateMessage('Login Failed:', res.error.message);
      } else if(res instanceof AuthData) {
		this.msgs.push({severity: 'success', summary: 'Login Success', detail: 'Your credentials verified successfully. Redirecting...' });
        //this.router.navigateByUrl('/dashboard');
		location.reload();			
      } else {
        this.updateMessage('Login Failed:', 'An unknown error occurred');
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
