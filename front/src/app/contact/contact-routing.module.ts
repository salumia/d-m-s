import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ContactListComponent } from './contact-list/contact-list.component';
import { ContactEditComponent } from './contact-edit/contact-edit.component';

const routes: Routes = [

  {path: 'contacts', component: ContactListComponent},
  {path: 'contact/create', component: ContactEditComponent},
  {path: 'contact/:user/edit/:id', component: ContactEditComponent},
  {path: 'vendor/:user/contacts', component: ContactListComponent}
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ContactRoutingModule { }

