import { BaseController } from "./base_controller"

export default class extends BaseController {

  static targets = ["toggle_button"];

  connect() {
    var context = this;
    context.toggle_state = Cookies.get('toggle_state') || 'off';

    $(context.toggle_buttonTarget).on('click', function(){
      context.toggle_state = context.toggle_state == 'off' ? 'on' : 'off'
      Cookies.set('toggle_state', context.toggle_state);
    });

    if(context.toggle_state == 'off'){
      KTLayout.getAsideToggler().toggleOff();
    }else{
      KTLayout.getAsideToggler().toggleOn();
    }
  }
}
