import { BaseController } from "./base_controller"

export default class extends BaseController {

  connect() {
    this.setSettings();

    var $el = $(this.element).find('input');

    $.fn.datetimepicker.dates['ru'] = {
        days: ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"],
        daysShort: ["Вос", "Пон", "Вто", "Сре", "Чет", "Пят", "Суб"],
        daysMin: ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
        months: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"],
        monthsShort: ["Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек"],
        today: "Сегодня",
        clear: "Очистить",
        format: "dd.mm.yyyy hh:ii",
        titleFormat: "MM yyyy",
        weekStart: 1,
        meridiem: ''
    };

    $el.datetimepicker({
        todayHighlight: true,
        autoclose: true,
        language: this.searchParams.get('locale')
    });
  }
}
