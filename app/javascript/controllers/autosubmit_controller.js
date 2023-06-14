import { Controller } from '@hotwired/stimulus'

export default class extends Controller {

  connect() {
  };

  submit() {
    console.log("Hello from Stimulus controller");
    ​this​.element.click();
  }
}
