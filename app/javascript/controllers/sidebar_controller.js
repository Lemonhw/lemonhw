import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  connect() {
    this.loadContent(this.data.get("url"))
  }

  loadContent(event) {
    event.preventDefault()

    const url = event.target.dataset.sidebarUrl

    fetch(url, { headers: { accept: "text/html" } })
      .then(response => response.text())
      .then(html => {
        const content = document.querySelector('#content')
        content.innerHTML = html
      })
  }
}
