import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule }   from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AuthService } from '../auth/auth.service';
import { UserService } from '../user/user.service';
import { CategoryService } from './category.service';
import { IndustryService } from './industry.service';
import { ContractTypeService } from './contract-type.service';
import { PartService } from './part.service';

import { Router, NavigationEnd } from '@angular/router';

import { ContractRoutingModule } from './contract-routing.module';
import { ListComponent } from './category/list/list.component';
import { EditComponent } from './category/edit/edit.component';

import { IndustryEditComponent } from './industry/industry-edit/industry-edit.component';
import { IndustryListComponent } from './industry/industry-list/industry-list.component';

import { TemplateModule } from "../template/template.module";

import { MenubarModule } from 'primeng/menubar';
import { TableModule } from "primeng/table";
import { ButtonModule } from "primeng/button";
import { DialogModule } from "primeng/dialog";
import { DropdownModule, InputTextModule, PasswordModule } from 'primeng/primeng';
import { MessagesModule } from 'primeng/messages';
import {SplitButtonModule} from 'primeng/splitbutton';

import {InputMaskModule} from 'primeng/inputmask';
import {CalendarModule} from 'primeng/calendar';
import {InputTextareaModule} from 'primeng/inputtextarea';
import {FileUploadModule} from 'primeng/fileupload';
import { GrowlModule } from 'primeng/growl';
import {ProgressSpinnerModule} from 'primeng/progressspinner';
import {TabViewModule} from 'primeng/tabview';
import { ContractTypeListComponent } from './type/contract-type-list/contract-type-list.component';
import { ContractTypeEditComponent } from './type/contract-type-edit/contract-type-edit.component';
import { GlobalEditComponent } from './part/global-edit/global-edit.component';
import { GlobalListComponent } from './part/global-list/global-list.component';

@NgModule({
  imports: [
    CommonModule,
	ContractRoutingModule,
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
  providers: [AuthService, UserService, CategoryService, IndustryService, ContractTypeService, PartService],
  declarations: [ListComponent, EditComponent, IndustryListComponent, IndustryEditComponent, ContractTypeListComponent, ContractTypeEditComponent, ContractTypeListComponent, GlobalEditComponent, GlobalListComponent]
})
export class ContractModule {
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