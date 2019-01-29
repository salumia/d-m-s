import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../auth/auth.service';
import { CategoryService } from '../../category.service';
import { User } from '../../../user/user';
import { Category } from '../../category';
import { Message } from 'primeng/api';
import { MessageService } from 'primeng/components/common/messageservice';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
  
export class ListComponent implements OnInit {
	categories: Category[] = [];
	msgs: Message[] = [];
	loggedInUser: User;
	cols: any[];

	constructor(private authService: AuthService, private categoryService: CategoryService, private messageService: MessageService) {}

	ngOnInit() {
		this.cols = [
			{ field: 'id', header: 'Id' },
			{ field: 'name', header: 'Name' }
		];
		  
		this.loadCategories();
		this.loggedInUser = this.authService.getAuth();
	}

	loadCategories() {
		this.categoryService.getCategories().subscribe(res => this.categories = res);
	}
	
	disableCategory(id: number) {
		this.categoryService.disableCategory(id).subscribe(res => {		
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Category Updated', detail: res.message});
			// Reload Categories
			this.loadCategories();
		});
	}

	enableCategory(id) {
		this.categoryService.enableCategory(id).subscribe(res => {
			this.messageService.add({key: 'top-corner', severity: 'success', summary: 'Category Updated', detail: res.message});

			// Reload Categories
			this.loadCategories();

		});
	}
}
