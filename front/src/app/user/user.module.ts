import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule }   from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AuthService } from '../auth/auth.service';
import { UserService } from './user.service';
import { Router, NavigationEnd } from '@angular/router';

import { UserRoutingModule } from './user-routing.module';
import { UserListComponent } from './user-list/user-list.component';
import { VendorListComponent } from './vendor-list/vendor-list.component';
import { UserEditComponent } from './user-edit/user-edit.component';
import { VendorEditComponent } from './vendor-edit/vendor-edit.component';
import { TemplateModule } from "../template/template.module";
import { MenubarComponent } from './menubar/menubar.component';
import { MenubarModule } from 'primeng/menubar';
import { TableModule } from "primeng/table";
import { ButtonModule } from "primeng/button";
import { DialogModule } from "primeng/dialog";
import { DropdownModule, InputTextModule, PasswordModule } from 'primeng/primeng';
import { MessagesModule } from 'primeng/messages';
import { DashboardComponent } from './dashboard/dashboard.component';
import {SplitButtonModule} from 'primeng/splitbutton';
import { NotfoundComponent } from './notfound/notfound.component';
import { Ng4GeoautocompleteModule } from 'ng4-geoautocomplete';
import {InputMaskModule} from 'primeng/inputmask';
import {CalendarModule} from 'primeng/calendar';
import {InputTextareaModule} from 'primeng/inputtextarea';
import {FileUploadModule} from 'primeng/fileupload';
import { GrowlModule } from 'primeng/growl';
import { ChangePasswordComponent } from './change-password/change-password.component';
import { ViewComponent } from './view/view.component';
import { VendorViewComponent } from './vendor-view/vendor-view.component';
import {ProgressSpinnerModule} from 'primeng/progressspinner';
import {TabViewModule} from 'primeng/tabview';
import { AdminViewComponent } from './admin-view/admin-view.component';
import { AdminEditComponent } from './admin-edit/admin-edit.component';

@NgModule({
  imports: [
    Ng4GeoautocompleteModule.forRoot(),
    CommonModule,
    UserRoutingModule,
    FormsModule,
	ReactiveFormsModule,
    TemplateModule,
    MenubarModule,
    TableModule,
    ButtonModule,
    DialogModule,
    PasswordModule,
    MessagesModule,
    InputTextModule,
    DropdownModule,
	SplitButtonModule,
	InputMaskModule,
	CalendarModule,
	InputTextareaModule,
	FileUploadModule,
	GrowlModule,
	ProgressSpinnerModule,
	TabViewModule
  ],
  providers: [AuthService, UserService],
  declarations: [UserListComponent, VendorListComponent 
      , UserEditComponent, VendorEditComponent,VendorViewComponent,
      MenubarComponent, DashboardComponent, NotfoundComponent, ChangePasswordComponent, ViewComponent, AdminViewComponent, AdminEditComponent]
})
export class UserModule {
  constructor(auth: AuthService, router: Router) {

    // Check login only if we are trying to use this module
    router.events
      .subscribe((event: NavigationEnd) => {
        if(event instanceof NavigationEnd && event.urlAfterRedirects.startsWith('/settings/users')) {

          // Check Permissions (skip checkLogin because it's checked in parent module /settings)
          auth.checkPermissions('user');

        }
      });

  }
}
