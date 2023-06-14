import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
  };

  submitForm(event) {
    event.preventDefault();

    console.log("Hello from Stimulus controller");
    this.element.submit();
  }
}
