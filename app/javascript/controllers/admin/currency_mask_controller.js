import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    var $el = $(this.element).find('input');

    $el.inputmask('999.999.999,99', {
      numericInput: true
    });
  }
}
