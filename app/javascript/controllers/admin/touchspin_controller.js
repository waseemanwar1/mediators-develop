import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    var $el = $(this.element).find('input');
    var min = $el.data('min');
    var max = $el.data('max');
    var step = $el.data('step');
    var decimals = $el.data('decimals');

    $el.TouchSpin({
        buttondown_class: 'btn btn-secondary',
        buttonup_class: 'btn btn-secondary',

        min: min,
        max: max,
        step: step,
        decimals: decimals,
        boostat: 5,
        maxboostedstep: 10,
    });
  }
}
