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
import { SplitButtonModule} from 'primeng/splitbutton';
import {InputMaskModule} from 'primeng/inputmask';
import {CalendarModule} from 'primeng/calendar';
import {InputTextareaModule} from 'primeng/inputtextarea';
import {FileUploadModule} from 'primeng/fileupload';
import {GrowlModule } from 'primeng/growl';
import {ProgressSpinnerModule} from 'primeng/progressspinner';
import {TabViewModule} from 'primeng/tabview';
import {DragDropModule} from 'primeng/dragdrop';
import {PickListModule} from 'primeng/picklist';
import {ConfirmDialogModule} from 'primeng/confirmdialog';
import {ConfirmationService} from 'primeng/api';

@NgModule({
  imports: [
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
	SplitButtonModule,
	InputMaskModule,
	CalendarModule,
	InputTextareaModule,
	FileUploadModule,
	GrowlModule,
	ProgressSpinnerModule,
	TabViewModule,
	DragDropModule,
	PickListModule,
	ConfirmDialogModule
  ],
  providers: [AuthService, UserService, ConfirmationService, ContactService],
  declarations: [ContactListComponent]
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