import { Component } from '@angular/core';
import { TemplateConfigService } from "./template/template-config.service";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';

  constructor(public template: TemplateConfigService) { }
}
