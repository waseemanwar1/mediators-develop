import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    this.setSettings();

    var input = $(this.element).find('input')[0];
    var whitelist = $(this.element).data('whitelist');
    var values = $(this.element).data('values');

    var options = {};
    if(Array.isArray(whitelist)){
      options['enforceWhitelist'] = true;
      options['whitelist'] = whitelist;
    }

    var tagify = new Tagify(input, options);
    tagify.removeAllTags();
    tagify.addTags(values);

    tagify.DOM.input.classList.add('form-control');
    tagify.DOM.scope.parentNode.insertBefore(tagify.DOM.input, tagify.DOM.scope);
  }
}
