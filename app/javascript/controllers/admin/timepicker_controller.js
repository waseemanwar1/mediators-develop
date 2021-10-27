import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    this.setSettings();

    var $el = $(this.element).find('input');

    $el.timepicker({
        minuteStep: 1,
        defaultTime: '',
        showSeconds: true,
        showMeridian: false,
        snapToStep: true
    });
  }
}
