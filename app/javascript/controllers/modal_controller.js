import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    document.addEventListener('turbo:submit-start', () => {
      this.showModal();
    });

    document.addEventListener('turbo:submit-end', () => {
      this.hideModal();
    });
  }

  showModal() {
    document.getElementById('modal').classList.remove('hidden');
  }

  hideModal() {
    document.getElementById('modal').classList.add('hidden');
  }
}
