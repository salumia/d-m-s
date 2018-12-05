import { Component, OnInit } from '@angular/core';
import {Location} from '@angular/common';
import { AuthService } from '../../auth/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {

	announcementsItems:any = [];
	departmentItems:any = [];
	calendarItems:any = [];
	loggedInUser:any = {};
	constructor(private _location: Location,private auth: AuthService,  private router: Router) {}

	ngOnInit() {
		this.loggedInUser = this.auth.getAuth();
	}
	
	goBack() {
        this._location.back();
    }

}
