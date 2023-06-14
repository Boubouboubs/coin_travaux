import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card-twilio-mobile"
export default class extends Controller {
  static targets = ["joinCallButton", "endCallButton", "twilio", "startBtn", "endBtn"]
  static values = {
    deviseType: String
  }

  connect() {
    console.log('Hi form card twilio')
  }

  startCall(event) {
    event.preventDefault();
    this.startBtnTarget.classList.add('d-none');
    this.endBtnTarget.classList.remove('d-none');
    this.twilioTarget.classList.remove("d-none");
    this.joinCallButtonTarget.click();
  }

  endCall(event) {
    event.preventDefault();
    this.endCallButtonTarget.click();
    this.startBtnTarget.classList.remove('d-none');
    this.endBtnTarget.classList.add('d-none');
    if (this.deviseTypeValue != "desktop") this.twilioTarget.classList.add("d-none");
  }
}
