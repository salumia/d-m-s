import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule }   from '@angular/forms';
import { CommonModule } from '@angular/common';

import { AuthRoutingModule } from './auth-routing.module';
import { LoginComponent } from './login/login.component';
import { LogoutComponent } from './logout/logout.component';

// Controls
import { PanelModule } from 'primeng/panel';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { MessagesModule } from 'primeng/messages';
import { MessageModule } from 'primeng/message';
import { SignupComponent } from './signup/signup.component';

import { InputMaskModule } from 'primeng/inputmask';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
	ReactiveFormsModule,
    AuthRoutingModule,
    PanelModule,
    ButtonModule,
    InputTextModule,
    MessagesModule,
    MessageModule,
	InputMaskModule
  ],
  declarations: [LoginComponent, LogoutComponent, SignupComponent]
})
export class AuthModule { }
