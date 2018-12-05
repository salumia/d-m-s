import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AppraisalRoutingModule } from './appraisal-routing.module';

import { FormsModule, ReactiveFormsModule }   from '@angular/forms';
import { Router, NavigationEnd } from '@angular/router';
import { TemplateModule } from "../template/template.module";
import { MenubarModule } from 'primeng/menubar';
import { TableModule } from "primeng/table";
import { ButtonModule } from "primeng/button";
import { DialogModule } from "primeng/dialog";
import { DropdownModule, InputTextModule, PasswordModule } from 'primeng/primeng';
import { MessagesModule } from 'primeng/messages';
import { SplitButtonModule} from 'primeng/splitbutton';
import { InputMaskModule} from 'primeng/inputmask';
import { CalendarModule} from 'primeng/calendar';
import { InputTextareaModule} from 'primeng/inputtextarea';
import { FileUploadModule} from 'primeng/fileupload';
import { GrowlModule } from 'primeng/growl';
import { RatingModule} from 'primeng/rating';
import {RadioButtonModule} from 'primeng/radiobutton';
import { DataScrollerModule } from 'primeng/datascroller';

import { AuthService } from '../auth/auth.service';
import { UserService } from '../user/user.service';
import { AppraisalService } from './appraisal.service';

import { SendAppraisalComponent } from './send-appraisal/send-appraisal.component';
import { AppraisalListComponent } from './appraisal-list/appraisal-list.component';
import { AppraisalFormComponent } from './appraisal-form/appraisal-form.component';

import {ConfirmDialogModule} from 'primeng/confirmdialog';
import {ConfirmationService} from 'primeng/api';

@NgModule({
  imports: [
    CommonModule,
    AppraisalRoutingModule,
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
	RatingModule,
	RadioButtonModule,
	DataScrollerModule,
	ConfirmDialogModule
	
  ],
  providers: [AuthService, UserService, AppraisalService, ConfirmationService],
  declarations: [SendAppraisalComponent, AppraisalListComponent, AppraisalFormComponent]
})

export class AppraisalModule { 
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
