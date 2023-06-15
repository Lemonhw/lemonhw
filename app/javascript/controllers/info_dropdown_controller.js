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
    if (this.buttonTarget.textContent == "More information") {
      this.buttonTarget.textContent = "Less information";
    } else if (this.buttonTarget.textContent == "Less information") {
        this.buttonTarget.textContent = "More information";
    } else if (this.buttonTarget.textContent == "Show instructions") {
        this.buttonTarget.textContent = "Hide instructions";
    } else if (this.buttonTarget.textContent == "Hide instructions") {
        this.buttonTarget.textContent = "Show instructions";
    }
  }
}
