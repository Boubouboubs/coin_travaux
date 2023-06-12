import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()
import { French } from "flatpickr-french";

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      enableTime: true,
      altInput: true,
      altFormat: "j F Y - H:i",
      dateFormat: "Y-m-d H:i",
      locale: French
    })
  }
}
