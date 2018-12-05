import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SendAppraisalComponent } from './send-appraisal/send-appraisal.component';
import { AppraisalListComponent } from './appraisal-list/appraisal-list.component';
import { AppraisalFormComponent } from './appraisal-form/appraisal-form.component';

const routes: Routes = [
	{path: 'appraisal/list', component: AppraisalListComponent},
	{path: 'appraisal/send', component: SendAppraisalComponent},
	{path: 'appraisal/update/:id', component: SendAppraisalComponent},
	{path: 'appraisal/form', component: AppraisalFormComponent},
	{path: 'appraisal/form/:id', component: AppraisalFormComponent},
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AppraisalRoutingModule { }
