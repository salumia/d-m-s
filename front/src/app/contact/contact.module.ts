import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule }   from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AuthService } from '../auth/auth.service';
import { UserService } from '../user/user.service';
import { ContactService } from './contact.service';

import { Router, NavigationEnd } from '@angular/router';

import { ContactRoutingModule } from './contact-routing.module';
import { ContactListComponent } from './contact-list/contact-list.component';

import { TemplateModule } from "../template/template.module";

import { MenubarModule } from 'primeng/menubar';
import { TableModule } from "primeng/table";
import { ButtonModule } from "primeng/button";
import { DialogModule } from "primeng/dialog";
import { DropdownModule, InputTextModule, PasswordModule } from 'primeng/primeng';
import { MessagesModule } from 'primeng/messages';
import {InputMaskModule} from 'primeng/inputmask';
import {InputTextareaModule} from 'primeng/inputtextarea';
import {GrowlModule } from 'primeng/growl';
import {ProgressSpinnerModule} from 'primeng/progressspinner';
import {TabViewModule} from 'primeng/tabview';
import {ConfirmDialogModule} from 'primeng/confirmdialog';
import {ConfirmationService} from 'primeng/api';
import { ContactEditComponent } from './contact-edit/contact-edit.component';
import { Ng4GeoautocompleteModule } from 'ng4-geoautocomplete';

@NgModule({
  imports: [
    Ng4GeoautocompleteModule.forRoot(),
    CommonModule,
	ContactRoutingModule,
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
	InputMaskModule,
	InputTextareaModule,
	GrowlModule,
	ProgressSpinnerModule,
	TabViewModule,
	ConfirmDialogModule,
  ],
  providers: [AuthService, UserService, ConfirmationService, ContactService],
  declarations: [ContactListComponent, ContactEditComponent]
})
export class ContactModule {
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