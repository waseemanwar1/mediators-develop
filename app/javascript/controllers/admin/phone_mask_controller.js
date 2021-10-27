import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    var $el = $(this.element).find('input');

    $el.inputmask("mask", {
      "mask": "(999) 999-9999"
    });
  }
}
