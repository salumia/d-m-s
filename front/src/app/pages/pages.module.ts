import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NavigationEnd, Router } from '@angular/router';
import { AuthService } from '../auth/auth.service';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MessageService } from 'primeng/components/common/messageservice';

@NgModule({
  imports: [
    CommonModule,
	FormsModule,
    ReactiveFormsModule
  ],
  providers: [AuthService, MessageService],
  declarations: []
})
export class PagesModule {
	constructor(auth: AuthService, router: Router) {

    // Check login only if we are trying to use this module
    router.events
      .subscribe((event: NavigationEnd) => {
        if(event instanceof NavigationEnd && event.urlAfterRedirects.startsWith('/agencies/list')) {

          // Check Login
          auth.checkLogin();

          // Check Permissions
          auth.checkPermissions('client');

        }
      });

  }
}

