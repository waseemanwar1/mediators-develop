import { BaseController } from "./base_controller"

export default class extends BaseController {

  static targets = [
    "admin_users", "groups", "permissions"
  ]

  connect(){
    // Set settings
    this.setSettings();

    var context = this;
    this.fix = false;
    this.fixModel = null;
    this.fixID = null;
    this.referencesUrl = $(this.element).data('references-url');
    this.admin_usersReferences = ["groups"]
    this.groupsReferences = ["admin_users", "permissions"]
    this.permissionsReferences = ["groups"]

    $('.searchable-list').bind("DOMSubtreeModified",function(){
      if(context.fix){
        context.checkFixed(context, event.target);
      }
    });
  }

  showReferences(event, force = false, withButtons = false) {
    if(force || !this.fix){
      var context = this;
      if(force){
        var model = this.fixModel;
        var id = this.fixID;
      }else{
        var elem = $(event.target).closest('.kt-widget-4');
        var model = elem.data('model');
        var id = elem.data('id');
        elem.addClass('permissions-shadow');
        elem.find('.edit-button').removeClass('kt-hidden');
      }

      var data = this.getReferences(model, id);

      $.each(data, function(key, values){

        $.each($(context[`${key}Targets`]), function(i, item){
          var $item = $(item);
          $item.removeClass('permissions-shadow');
          if(withButtons){
            if($.inArray(`${context.fixModel}s`, context[`${key}References`]) != -1){
              $item.find('.plus-button').removeClass('kt-hidden');
              $item.find('.minus-button').addClass('kt-hidden');
            }
          }else{
            $item.find('.plus-button').addClass('kt-hidden');
          }
        });

        $.each(values['ids'], function(i, value){
          var items = $(context[`${key}Targets`]).filter(`[data-id="${value}"]`);
          $.each(items, function(i, item){
            var $item = $(item);
            $item.addClass('permissions-shadow');
            if(withButtons){
              if($.inArray(`${context.fixModel}s`, context[`${key}References`]) != -1){
                $item.find('.plus-button').addClass('kt-hidden');
                $item.find('.minus-button').removeClass('kt-hidden');
              }
            }else{
              $item.find('.minus-button').addClass('kt-hidden');
            }
          });
        });
      });
    }
  }

  hideReferences() {
    if(!this.fix){
      var context = this;
      var elem = $(event.target).closest('.kt-widget-4');
      var model = elem.data('model');
      var id = elem.data('id');

      var data = this.getReferences(model, id);

      $.each(data, function(key, values){
        $.each(values['ids'], function(i, value){
          $(context[`${key}Targets`]).filter(`[data-id="${value}"]`).removeClass('permissions-shadow');
        })
      });
      elem.removeClass('permissions-shadow');
      elem.find('.edit-button').addClass('kt-hidden');
    }
  }

  fixReferences() {
    var elem = $(event.target).closest('.kt-widget-4');
    var model = elem.data('model');
    var id = elem.data('id');

    if(this.fix && model == this.fixModel && id == this.fixID){
      this.fix = false;
      elem.removeClass('shadow-active');
      this.showReferences(null, true);
    }else if(!this.fix){
      this.fix = true;
      this.fixModel = model;
      this.fixID = id;
      elem.addClass('shadow-active');
      elem.find('.edit-button').addClass('kt-hidden');
      this.showReferences(null, true, true);
    }
  }

  getReferences(model, id){
    var data;
    $.ajax({
        type: 'GET',
        url: this.referencesUrl,
        data: { model: model, id: id },
        dataType: "json",
        async: false,
        success: function(responce){
          data = responce;
        }
    });
    return data;
  }

  checkFixed(context, elem){
    $.each($(elem).children(), function(i, e){
      var $elem = $(e);
      var model = $elem.data('model');
      var id = $elem.data('id');

      if(context.fix && model == context.fixModel && id == context.fixID){
        $elem.addClass('permissions-shadow shadow-active');
      }
      context.showReferences(null, true, context.fix);
    });
  }

  addUser(){
    var elem = $(event.target).closest('.plus-button');
    var id = elem.closest('.kt-widget-4').data('id');
    this.addReferences(this.fixModel, this.fixID, 'admin_users', id);
  }

  removeUser(){
    var elem = $(event.target).closest('.minus-button');
    var id = elem.closest('.kt-widget-4').data('id');
    this.removeReferences(this.fixModel, this.fixID, 'admin_users', id);
  }

  addGroup(){
    var elem = $(event.target).closest('.plus-button');
    var id = elem.closest('.kt-widget-4').data('id');
    this.addReferences(this.fixModel, this.fixID, 'groups', id);
  }

  removeGroup(){
    var elem = $(event.target).closest('.minus-button');
    var id = elem.closest('.kt-widget-4').data('id');
    this.removeReferences(this.fixModel, this.fixID, 'groups', id);
  }

  addPermission(){
    var elem = $(event.target).closest('.plus-button');
    var id = elem.closest('.kt-widget-4').data('id');
    this.addReferences(this.fixModel, this.fixID, 'permissions', id);
  }

  removePermission(){
    var elem = $(event.target).closest('.minus-button');
    var id = elem.closest('.kt-widget-4').data('id');
    this.removeReferences(this.fixModel, this.fixID, 'permissions', id);
  }

  addReferences(model, id, set_model, set_id){
    var context = this;
    $.ajax({
        type: 'POST',
        url: '/admin/permissions/add_references',
        data: { model: model, id: id, set_model: set_model, set_id: set_id },
        dataType: "json",
        async: false,
        success: function(data){
          context.showReferences(null, true, true);
        }
    });
  }

  removeReferences(model, id, set_model, set_id){
    var context = this;
    $.ajax({
        type: 'POST',
        url: '/admin/permissions/remove_references',
        data: { model: model, id: id, set_model: set_model, set_id: set_id, locale: context.searchParams.get('locale') },
        dataType: "json",
        async: false,
        success: function(data){
          context.showReferences(null, true, true);
        }
    });
  }

  updateReferences(model, id, set_model, set_id, action){
    // var $elem = $(this[`${set_model}Targets`]).filter(`[data-id="${set_id}"]`);
    // if(action == 'add'){
      // this.showReferences(null, true, true);
      // $elem.addClass('permissions-shadow');
      // $elem.find('.minus-button').removeClass('kt-hidden');
      // $elem.find('.plus-button').addClass('kt-hidden');
    // }else{
      // this.showReferences(null, true, true);
      // $elem.removeClass('permissions-shadow');
      // $elem.find('.minus-button').addClass('kt-hidden');
      // $elem.find('.plus-button').removeClass('kt-hidden');
    // }
  }
}
