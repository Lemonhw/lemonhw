import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ['day', 'tab']

  connect() {
    console.log('hi')
  }

  switchTab(e) {
    // find the targetId of the clicked element
    const targetId = e.currentTarget.dataset.targetId

    // remove active class from all tabs
    this.tabTargets.forEach((tab) => {
      tab.classList.remove("active")
    })

    // add active class to clicked tab
    e.currentTarget.classList.add("active")

    // get the target element with the Id
    const targetElement = this.dayTargets.find((day) => day.dataset.dayId === targetId)

    // remove active class from the other days
    const days = this.dayTargets.forEach((day) => {
      day.classList.remove("active")
    })

    // add active class to the targetElement
    targetElement.classList.add("active")
  }
}
