import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule }   from '@angular/forms';
import { CommonModule } from '@angular/common';

import { AuthRoutingModule } from './auth-routing.module';
import { LoginComponent } from './login/login.component';
import { VendorLoginComponent } from './vendor-login/vendor-login.component';
import { AdminLoginComponent } from './admin-login/admin-login.component';
import { ForgotPasswordComponent } from './forgot-password/forgot-password.component';
import { LogoutComponent } from './logout/logout.component';

// Controls
import { PanelModule } from 'primeng/panel';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { MessagesModule } from 'primeng/messages';
import { MessageModule } from 'primeng/message';
import { SignupComponent } from './signup/signup.component';

import { InputMaskModule } from 'primeng/inputmask';
import { Ng4GeoautocompleteModule } from 'ng4-geoautocomplete';

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
	InputMaskModule,
	Ng4GeoautocompleteModule
  ],
  declarations: [LoginComponent, VendorLoginComponent, AdminLoginComponent, ForgotPasswordComponent,LogoutComponent, SignupComponent]
})
export class AuthModule { }
