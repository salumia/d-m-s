import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule }   from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AuthService } from '../auth/auth.service';
import { UserService } from '../user/user.service';
import { CategoryService } from './category.service';
import { IndustryService } from './industry.service';
import { ContractTypeService } from './contract-type.service';
import { PartService } from './part.service';
import { SetService } from './set.service';
import { ContractService } from './contract.service';

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
import { SplitButtonModule} from 'primeng/splitbutton';

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
import { SetListComponent } from './set-list/set-list.component';
import { SetEditComponent } from './set-edit/set-edit.component';
import {DragDropModule} from 'primeng/dragdrop';
import {PickListModule} from 'primeng/picklist';
import {ConfirmDialogModule} from 'primeng/confirmdialog';

import {ConfirmationService} from 'primeng/api';
import { PartListComponent } from './part/part-list/part-list.component';
import { PartEditComponent } from './part/part-edit/part-edit.component';

import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { CreateContractComponent } from './create-contract/create-contract.component';

import {FieldsetModule} from 'primeng/fieldset';
import {ListboxModule} from 'primeng/listbox';
import { ContractListComponent } from './contract-list/contract-list.component';
import { ContractReviewComponent } from './contract-review/contract-review.component';

import {CardModule} from 'primeng/card';
import { ContractPreviewComponent } from './contract-preview/contract-preview.component';

import {CaptchaModule} from 'primeng/captcha';
import { AdminContractListComponent } from './admin-contract-list/admin-contract-list.component';

import {AccordionModule} from 'primeng/accordion';
import {AutoCompleteModule} from 'primeng/autocomplete';
import { AccessContractComponent } from './access-contract/access-contract.component';

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
	TabViewModule,
	DragDropModule,
	PickListModule,
	ConfirmDialogModule,
	BrowserAnimationsModule,
	FieldsetModule,
	ListboxModule,
	CardModule,
	CaptchaModule,
	AccordionModule,
	AutoCompleteModule
  ],
  providers: [AuthService, UserService, CategoryService, IndustryService, ContractTypeService, PartService, SetService, ConfirmationService, ContractService],
  declarations: [ListComponent, EditComponent, IndustryListComponent, IndustryEditComponent, ContractTypeListComponent, ContractTypeEditComponent, ContractTypeListComponent, GlobalEditComponent, GlobalListComponent, SetListComponent, SetEditComponent, PartListComponent, PartEditComponent, CreateContractComponent, ContractListComponent, ContractReviewComponent, ContractPreviewComponent, AdminContractListComponent, AccessContractComponent]
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