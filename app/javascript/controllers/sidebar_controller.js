import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  connect() {
    // this.loadContent(this.data.get("url"))
  }

  loadContent(event) {
    event.preventDefault()

    const url = event.target.dataset.sidebarUrl

    fetch(url, { headers: { accept: "text/html" } })
      .then(response => response.text())
      .then(html => {
        const contentWindow = document.querySelector('#content')
        const element = document.createElement('div')
        element.innerHTML = html
        const newContent = element.querySelector('#dashboard-content').innerHTML

        contentWindow.innerHTML = newContent
      })
  }
}
