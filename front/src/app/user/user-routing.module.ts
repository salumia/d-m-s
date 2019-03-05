import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { UserListComponent } from './user-list/user-list.component';
import { UserEditComponent } from './user-edit/user-edit.component';
import { ViewComponent } from './view/view.component';

import { VendorListComponent } from './vendor-list/vendor-list.component';
import { VendorEditComponent } from './vendor-edit/vendor-edit.component';
import { VendorViewComponent } from './vendor-view/vendor-view.component';

import { AdminViewComponent } from './admin-view/admin-view.component';
import { AdminEditComponent } from './admin-edit/admin-edit.component';

import { DashboardComponent } from './dashboard/dashboard.component';
import { NotfoundComponent } from './notfound/notfound.component';
import { ChangePasswordComponent } from './change-password/change-password.component';

const routes: Routes = [
  {path: 'settings/users', component: UserListComponent},
  {path: 'users', component: UserListComponent},
  {path: 'users/create', component: UserEditComponent},  
  {path: 'users/edit/:id', component: UserEditComponent},
  {path: 'settings/users/create', component: UserEditComponent},
  {path: 'settings/users/edit/:id', component: UserEditComponent},
  {path: 'users/view/:id', component: ViewComponent},
  {path: 'user/change-password', component: ChangePasswordComponent},
  
  {path: 'vendors', component: VendorListComponent},
  {path: 'vendor/create', component: VendorEditComponent},
  {path: 'vendor/edit/:id', component: VendorEditComponent},
  {path: 'vendor/view/:id', component: VendorViewComponent},  
  {path: 'vendor/change-password', component: ChangePasswordComponent},
    
  {path: 'admin/change-password', component: ChangePasswordComponent},
  {path: 'admin/view/:id', component: AdminViewComponent},
  {path: 'admin/edit/:id', component: AdminEditComponent},
  
  {path: 'dashboard', component: DashboardComponent},
  {path: 'underconstruction', component: NotfoundComponent},
  
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UserRoutingModule { }
