import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    // basic demo
    var $el = $(this.element).find('textarea');

    autosize($el);
  }
}
