import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ContactListComponent } from './contact-list/contact-list.component';
import { ContactEditComponent } from './contact-edit/contact-edit.component';

const routes: Routes = [

  {path: 'contacts', component: ContactListComponent},
  {path: 'contact/create', component: ContactEditComponent},
  {path: 'contact/edit/:id', component: ContactEditComponent},
  
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ContactRoutingModule { }

