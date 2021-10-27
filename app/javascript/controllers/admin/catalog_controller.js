import { BaseController } from "./base_controller"

export default class extends BaseController {

  static targets = ['container', 'current_page', 'toolbar', 'empty']

  connect() {
    // Set settings
    this.setSettings();

    $('.select-filter').selectpicker();

    var urlParams = new URLSearchParams(window.location.search);

    this.page = 1;
    this.per = 20;
    this.order = urlParams.get('order') || 'desc';
    this.order_by = urlParams.get('order_by') || 'id';
    this.match = urlParams.get('match') || 'word_start';
    this.filters = {};
    this.elasticsearch = false;

    this.set_order_icon();
    this.search();
  }

  search() {
    var context = this;
    var url = this.data.get("url");

    this.query = $(this.toolbarTarget).find('#query').val();

    if(this.query) {
      this.elasticsearch = true;
    }

    $(this.current_pageTarget).val(this.page);

    $.ajax({
        type: 'GET',
        url: url,
        data: {
          page: context.page,
          per: context.per,
          order_by: context.order_by,
          order: context.order,
          where: context.filters,
          match: context.match,
          query: context.query,
          elasticsearch: context.elasticsearch
        },
        dataType: "html",
        success: function(html){
          context.containerTarget.innerHTML = html
          if(html){
            $(context.emptyTarget).addClass('kt-hidden');
          }else{
            $(context.emptyTarget).removeClass('kt-hidden');
          }
        }
    });
  }

  prev_page() {
    this.elasticsearch = true;
    var pageValue = this.page - 1;
    if(pageValue > 0) {
      this.page = pageValue;
      $(this.current_pageTarget).val(this.page);
      this.search();
    }
  }

  next_page() {
    this.elasticsearch = true;
    this.page = this.page + 1;
    $(this.current_pageTarget).val(this.page);
    this.search();
  }

  show_page() {
    this.elasticsearch = true;
    this.page = parseInt($(this.current_pageTarget).val())
    this.search();
  }

  sort(){
    this.elasticsearch = true;
    var $el = $(event.target).closest('th');
    var order = $el.data('order');

    this.order_by = order;

    if(this.order){
      if(this.order == 'asc'){
        this.order = 'desc';
      }else{
        this.order = 'asc';
      }
    }else{
      this.order = 'desc';
    }
    this.set_order_icon();
    this.search();
  }

  set_order_icon(){
    var icon = $(`.sort_icon`);
    icon.removeClass('flaticon2-arrow-up').removeClass('flaticon2-arrow-down');
    // icon.closest('span').removeClass('sorted-field');

    if(this.order && this.order_by){
      // icon.addClass('fa').addClass('fa-sort');
      var icon = $(`.sort_icon.${this.order_by}`);
      // icon.closest('span').addClass('sorted-field');
      if(this.order == 'asc'){
        // icon.removeClass('fa').removeClass('fa-sort');
        icon.addClass('flaticon2-arrow-up');
      }else{
        // icon.removeClass('fa').removeClass('fa-sort');
        icon.addClass('flaticon2-arrow-down');
      }
    }
  }

  filter(){
    this.elasticsearch = true;
    var name = $(event.target).attr('name');
    var value = $(event.target).val();

    this.filters[name] = value;
    this.search();
  }
}
