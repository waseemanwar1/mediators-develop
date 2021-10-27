import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    this.setSettings();

    var $el = $(this.element).find('select');

    $el.select2({
        placeholder: $(this.element).data('placeholder')
    });
  }
}
