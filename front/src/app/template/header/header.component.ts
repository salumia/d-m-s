import { Component, OnInit } from '@angular/core';
import {MenuItem} from 'primeng/api';
import { HttpErrorResponse } from '@angular/common/http';
import { PagesService } from '../../pages/pages.service';
import { AuthService } from '../../auth/auth.service';
import { TemplateConfigService } from '../template-config.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {
  items: MenuItem[];
  menuStaticPages: any;
  loggedInMenus: boolean = false;
  userData: any = '';
  activeAppraisal: boolean = false;
  reviewAppraisalList: boolean = false;
  
  constructor(private pageService: PagesService, private auth: AuthService,private templateService: TemplateConfigService) {
        this.templateService.listen().subscribe((m:any) => {
            this.refreshHeader();
        })
    }


  ngOnInit() {   
	this.items = [];
	this.loadDynamicPages();
	
	this.userData = this.auth.getAuth();
	
	if(this.userData != null){
		console.log(this.userData);
		if(this.userData.department == 1 || this.userData.role == 'admin'){
			this.reviewAppraisalList = true;
		}
		this.setSettingMenus();
	}
	
	
	console.log('Loggedin DATA');
	console.log(this.userData);
	console.log(this.loggedInMenus);	
  }
  
  setSettingMenus(){
		if(this.items.length == 0){
			if(this.userData.role == "vendor"){
				this.items.push({label: 'Profile', icon: 'fa-user', routerLink: '/vendor/view/'+this.userData.id});
				this.items.push({label: 'Edit Profile', icon: 'fa-pencil', routerLink: '/vendor/edit/'+this.userData.id});
				this.items.push({label: 'Change Password', icon: 'fa-lock', routerLink: '/vendor/change-password'});
			} else if(this.userData.role == "admin"){
				this.items.push({label: 'Profile', icon: 'fa-user', routerLink: '/admin/view/'+this.userData.id});
				this.items.push({label: 'Edit Profile', icon: 'fa-pencil', routerLink: '/admin/edit/'+this.userData.id});
				this.items.push({label: 'Change Password', icon: 'fa-lock', routerLink: '/admin/change-password'});
			} else {
				this.items.push({label: 'Profile', icon: 'fa-user', routerLink: '/users/view/'+this.userData.id});
				this.items.push({label: 'Edit Profile', icon: 'fa-pencil', routerLink: '/users/edit/'+this.userData.id});
				this.items.push({label: 'Change Password', icon: 'fa-lock', routerLink: '/user/change-password'});
			}
			
			this.items.push({label: 'Logout', icon: 'fa-sign-out', routerLink: '/logout'});
		}
		this.loggedInMenus = true;
	}
  
  loadDynamicPages(){	
	console.log('calling');
	this.pageService.getPages().subscribe(res => {
            this.menuStaticPages = res;
        });  
  }
  
  refreshHeader() {
	console.log('header refresh');
	this.loadDynamicPages(); 	
	
	this.userData = this.auth.getAuth();
	this.setSettingMenus();
	if(this.userData != null){
	} else {
		this.loggedInMenus = false;
		this.activeAppraisal = false;
		this.reviewAppraisalList = false;
	}
	
	
	
  }

}