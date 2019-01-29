import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CategoryService } from '../../category.service';
import { Category } from '../../category';
import { Message, SelectItem } from 'primeng/api';
import { Validators, FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { AuthService } from '../../../auth/auth.service';
import { MessageService } from 'primeng/components/common/messageservice';
import { Location} from '@angular/common';

@Component({
  selector: 'app-edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.css']
})
export class EditComponent implements OnInit {
	@ViewChild('documentsChild') documentsChild;
	id: number;
	category: Category = {} as Category;
	msgs: Message[] = [];
	Categoryform: FormGroup;
	loadComponents: boolean = false;
	loggedInUser: any;
	loadSpinner: boolean = false;

	constructor(aroute: ActivatedRoute, private router: Router, private categoryService: CategoryService, private fb: FormBuilder, private auth: AuthService, private messageService: MessageService, private _location: Location) {
		aroute.params.subscribe(params => {
			this.id = params['id'];
			if(this.id > 0){
			  this.loadSpinner = true;
			}
		});
	}

	ngOnInit() {

		this.loggedInUser = this.auth.getAuth();

		this.Categoryform = this.fb.group({
			'name': new FormControl('', Validators.required)
			});

		if(this.id > 0 ){
			this.loadcategory();
		}
	}
  
	loadcategory() {
		// Load category
		this.categoryService.getCategory(this.id).subscribe(res => {
		  this.category = res;
		  this.loadComponents = true;
		  this.loadSpinner = false;
		});

	}
    
	saveCategory() {
		console.log(this.category);
		this.categoryService.saveCategory(this.id, this.category).subscribe(res => {

			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Success', detail: res.message});
			setTimeout(() => {
				this.router.navigate(['categories']);
			}, 2000);
		});
	}
	
	goBack() {
        this._location.back();
    }
}
