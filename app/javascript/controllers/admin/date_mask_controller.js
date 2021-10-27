import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    var $el = $(this.element).find('input');

    $el.inputmask('99/99/9999', {
      'placeholder': 'dd/mm/yyyy'
    });
  }
}
