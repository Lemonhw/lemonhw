import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="info-dropdown"
export default class extends Controller {
  static targets = [ "button", "content" ]

  connect() {
    console.log("HELLO")
  }

  toggle() {
    this.contentTarget.classList.toggle('content-expanded');
    // this.contentTarget.classList.toggle('expanded');
  }
}
