import { BrowserModule } from '@angular/platform-browser';
import {Injector, NgModule} from '@angular/core';
import { createCustomElement } from '@angular/elements';

import { AppComponent } from './app.component';
import { ListComponent } from './components/list/list.component';

@NgModule({
  declarations: [
    AppComponent,
    ListComponent
  ],
  imports: [
    BrowserModule
  ],
  entryComponents: [
    ListComponent
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { constructor(private injector: Injector) {}

  ngDoBootstrap() {
    const appComponent = createCustomElement(AppComponent, { injector: this.injector });
    customElements.define('app-root', appComponent);

    /*const listComponent = createCustomElement(ListComponent, { injector: this.injector });
    customElements.define('app-list', listComponent);*/
  }
}

