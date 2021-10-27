import { BaseController } from "./base_controller"

export default class extends BaseController {

  static targets = ["toggle_button"];

  connect() {
    new KTAvatar(this.element);
  }
}
