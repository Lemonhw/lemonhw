import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  loadContent(event) {
    event.preventDefault()

    const url = event.target.dataset.tabsUrl

    fetch(url, { headers: { accept: "text/html" } })
      .then(response => response.text())
      .then(html => {
        const content = event.target.closest('.card').querySelector('.tab-content')
        content.innerHTML = html
      })
  }
}
