import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { UserService } from '../user.service';
import { User } from '../user';
import { AuthService } from '../../auth/auth.service';
import { Location} from '@angular/common';

@Component({
  selector: 'app-view',
  templateUrl: './view.component.html',
  styleUrls: ['./view.component.css']
})
export class ViewComponent implements OnInit {

	id: number;
	user: User = {} as User;
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
		this.userService.getUser(this.id).subscribe(res => {
			this.user = res;
			this.loadUserData = true;
			console.log(this.user);
		});
	
	}
	
	goBack() {
        this._location.back();
    }

}
