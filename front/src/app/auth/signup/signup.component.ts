import { Component, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from '../../user/user.service';
import { User } from '../../user/user';
import { Message, SelectItem } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { MessageService } from 'primeng/components/common/messageservice';

import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {
	user: User = {} as User;
	roles: SelectItem[];
	departments: SelectItem[];
	designations: SelectItem[];
	msgs: Message[] = [];
	Userform: FormGroup;

	constructor(private userService: UserService, private router: Router, private fb: FormBuilder, private messageService: MessageService) {}

	ngOnInit() {
		this.Userform = this.fb.group({
			'first_name': new FormControl('', Validators.required),            
			'last_name': new FormControl('', Validators.required),            
			'father_name': new FormControl('', Validators.required),            
			'mother_name': new FormControl('', Validators.required),
			'email': new FormControl('', Validators.compose([Validators.required, Validators.email]),this.isEmailUnique.bind(this)),					
			'phone': new FormControl('', Validators.required),            
			'alt_phone': new FormControl(''),            
			'correspondence_address': new FormControl('', Validators.required),            
			'permanent_address': new FormControl('', Validators.required),            
			'password': new FormControl('')
		});
	}

    isEmailUnique(control: FormControl) {
        const q = new Promise((resolve, reject) => {
            setTimeout(() => {
                this.userService.isEmailRegisterd(control.value,0).subscribe(res => {
                    console.log('Check Email Calling'+res);
                    if(res == 0){
                        resolve(null);
                    } else {
                        resolve({ 'isEmailUnique': true });
                    }
                });
            }, 1000);
        });
        return q;
    }        
	
	saveUser() {
		console.log(this.user);
		this.userService.saveVendor(0, this.user).subscribe(res => {
			if(res instanceof HttpErrorResponse) {
				this.updateMessage('Sign up Failed:', res.error.message, 'error');
			} else {
				this.updateMessage('Success :', res.message, 'success');
				setTimeout(() => {
					this.router.navigate(['vendor-login']);
				}, 2000);
			}
		});
	}
	
	private updateMessage(summary:string, detail:string, severity:string) {
		this.msgs = [];
		this.msgs.push({
		  severity: severity,
		  summary: summary,
		  detail: detail
		});
	  }
}
