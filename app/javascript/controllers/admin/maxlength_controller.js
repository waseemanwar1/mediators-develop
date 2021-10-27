import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    var $el = $(this.element).find('input');

    $el.maxlength({
        warningClass: "kt-badge kt-badge--success kt-badge--rounded kt-badge--inline",
        limitReachedClass: "kt-badge kt-badge--primary kt-badge--rounded kt-badge--inline"
    });
  }
}
