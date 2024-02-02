import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="album-modal"
export default class extends Controller {
  // ターゲットの定義
  static targets = ["albumModal", "background"]

  // connectメソッドは、HTMLからコントローラーに繋がれた際に呼ばれるアクション
  connect() {
    this.currentModalId = null;
  }

  // 『イラスト説明』リンククリック時に、モーダルを表示するアクション
  openModal(event) {
    event.preventDefault();
    const illustrationId = event.currentTarget.getAttribute("data-illustration-id");
    const modalId = `illustrationModal-${illustrationId}`;
    const modal = document.getElementById(modalId);
    if (modal) {
      modal.classList.remove("hidden");
      document.body.setAttribute("data-current-modal-id", modalId); // モーダルIDを<body>のデータ属性として保存
    } else {
      console.error(`Element with ID ${modalId} not found`); // コンソール確認用
    }
  }

  // モーダルを閉じるアクション
  closeModal() {
    const modalId = document.body.getAttribute("data-current-modal-id"); // <body>からモーダルIDを取得
    const modal = document.getElementById(modalId);
    if (modal) {
      modal.classList.add("hidden");
      document.body.removeAttribute("data-current-modal-id"); // データ属性のクリア
    } else {
      console.error(`Element with ID ${modalId} not found`); // コンソール確認用
    }
  }

  // モーダルの外をクリックした際に、モーダルを閉じるアクション
  closeBackground(event) {
    // イベントハンドラ内のターゲットとbackGroundTargetが同じ場合trueを返す。(モーダル外をクリックしているか確認)
    if(event.target === this.backgroundTarget) {
      this.closeModal();
    }
  }

  doNothing(event) {
    event.stopPropagation();
  }
}
