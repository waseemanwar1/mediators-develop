import { BaseController } from "./base_controller"

export default class extends BaseController {

  static targets = ['list']

  connect() {
    // Set settings
    this.setSettings();

    this.load('*');
  }

  search() {
    var search = event.target.value ? event.target.value : '*';
    this.load(search);
  }

  load(search) {
    var context = this;
    var url = this.data.get("url");

    $.ajax({
        type: 'GET',
        url: url,
        data: { search: search },
        dataType: "html",
        success: function(html){
          context.listTarget.innerHTML = html
        }
    });
  }
}
