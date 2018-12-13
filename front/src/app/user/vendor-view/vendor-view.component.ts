import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { UserService } from '../user.service';
import { Vendor } from '../vendor';
import { AuthService } from '../../auth/auth.service';
import {Location} from '@angular/common';

@Component({
  selector: 'app-vendor-view',
  templateUrl: './vendor-view.component.html',
  styleUrls: ['./vendor-view.component.css']
})
export class VendorViewComponent implements OnInit {

	id: number;
	user: Vendor = {} as Vendor;
	loggedInUser: any;
	loadUserData: boolean = false;
	  
	constructor(aroute: ActivatedRoute, private router: Router, private userService: UserService, private auth: AuthService, private _location: Location) {
		aroute.params.subscribe(params => {
			this.id = params['id'];
		});
	}
	ngOnInit() {
		this.loggedInUser = this.auth.getAuth();
		this.loadUser();	 
	}

	loadUser() {
		// Load User
		this.userService.getVendor(this.id).subscribe(res => {
			this.user = res;
			this.loadUserData = true;
		});
	}
	
	goBack() {
        this._location.back();
    }

}
