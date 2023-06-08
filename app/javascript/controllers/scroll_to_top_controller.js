import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "scrollButton" ]

  connect() {
    this.scrollCheck()
    this.checkButtonVisibility()
  }

  scrollCheck() {
    window.addEventListener("scroll", () => {
      this.checkButtonVisibility()
    });
  }

  checkButtonVisibility() {
    if (window.pageYOffset > 20) {
      this.scrollButtonTarget.style.display = "block";
    } else {
      this.scrollButtonTarget.style.display = "none";
    }
  }

  scrollToTop() {
    window.scrollTo({ top: 0, behavior: "smooth" });
  }
}
