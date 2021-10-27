import { Controller } from "stimulus"

export class BaseController extends Controller {

  setSettings(){
    var context = this;
    this.searchParams = new URLSearchParams(window.location.search);

    $.ajaxSetup({
      error: function(data, status, xhr){
        if(data.responseJSON['errors']){
          $.each(data.responseJSON['errors'], function(i, error){
            context.showSystemAlert(`${error['text']}`, `${error['type']}`);
          });
        }else{
          context.showSystemAlert(`${data.status}: ${xhr}`, 'danger');
        }
      }
    });
  }

  showSystemAlert(text, type){
    var $el = $(`
      <div class="alert alert-${type} alert-bold alert-system" role="alert">
        <div class="alert-text">${text}</div>
        <div class="alert-close">
          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true"><i class="la la-close"></i></span>
          </button>
        </div>
      </div>
    `);
    setTimeout(function () { $el.fadeOut('slow', function(){ $el.remove(); }); }, 5000);
    $('.alert-system-container').append($el);
  }
}
