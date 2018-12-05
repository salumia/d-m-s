import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { UserListComponent } from './user-list/user-list.component';
import { UserEditComponent } from './user-edit/user-edit.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { NotfoundComponent } from './notfound/notfound.component';
import { ChangePasswordComponent } from './change-password/change-password.component';
import { ViewComponent } from './view/view.component';

const routes: Routes = [
  {path: 'settings/users', component: UserListComponent},
  {path: 'users', component: UserListComponent},
  {path: 'users/create', component: UserEditComponent},
  {path: 'settings/users/create', component: UserEditComponent},
  {path: 'users/edit/:id', component: UserEditComponent},
  {path: 'settings/users/edit/:id', component: UserEditComponent},
  {path: 'dashboard', component: DashboardComponent},
  {path: 'underconstruction', component: NotfoundComponent},
  {path: 'users/change-password', component: ChangePasswordComponent},
  {path: 'users/view/:id', component: ViewComponent},
  
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UserRoutingModule { }
