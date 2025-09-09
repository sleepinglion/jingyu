// app/javascript/controllers/user_selector_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "hiddenInput", "userList"]

    connect() {
        this.loadUsers()
    }

    async loadUsers() {
        const response = await fetch("/admin/users.json")
        const users = await response.json()
        this.userListTarget.innerHTML = users.map(user => `
      <div class="list-group-item list-group-item-action" 
           data-action="click->user-selector#selectUser" 
           data-user-id="${user.id}" 
           data-user-nickname="${user.nickname}">
        ${user.nickname} (${user.email})
      </div>
    `).join("")
    }

    selectUser(event) {
        const userId = event.currentTarget.dataset.userId
        const userNickname = event.currentTarget.dataset.userNickname

        this.inputTarget.value = userNickname
        this.hiddenInputTarget.value = userId

        // Bootstrap 모달 닫기
        const modal = bootstrap.Modal.getInstance(document.getElementById('userSelectorModal'))
        modal.hide()
    }
}
