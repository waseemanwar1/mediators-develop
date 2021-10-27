import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    var $el = $(this.element);

    setTimeout(function () { $el.fadeOut('slow', function(){ $el.remove(); }); }, 5000);
  }
}
