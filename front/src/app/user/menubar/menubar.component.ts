import { Component, OnInit } from '@angular/core';
import { MenuItem } from "primeng/api";

@Component({
  selector: 'user-menubar',
  templateUrl: './menubar.component.html',
  styleUrls: ['./menubar.component.css']
})
export class MenubarComponent implements OnInit {

  public items: MenuItem[];

  constructor() { }

  ngOnInit() {
    this.items = [
      {
        label: 'Create User',
        icon: 'fa-user',
        routerLink: [ '/users/create' ],
        routerLinkActiveOptions: { exact: true }
      }
    ];
  }

}
