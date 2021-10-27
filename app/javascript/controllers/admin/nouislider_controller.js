import { BaseController } from "./base_controller"

export default class extends BaseController {

  static targets = ["slider"];

  connect() {
    var slider = this.sliderTarget;
    var $el = $(this.element);

    noUiSlider.create(slider, {
        start: [ $el.data('start') ],
        step: $el.data('step'),
        tooltips: [true],
        range: {
            'min': [ $el.data('min') ],
            'max': [ $el.data('max') ]
        },
        connect: [true, false],
        format: wNumb({ decimals: $el.data('decimals') })
    });

    var sliderInput = $(this.element).find('input')[0];

    slider.noUiSlider.on('update', function( values, handle ) {
        sliderInput.value = values[handle];
    });

    sliderInput.addEventListener('change', function(){
        slider.noUiSlider.set(this.value);
    });
  }
}
