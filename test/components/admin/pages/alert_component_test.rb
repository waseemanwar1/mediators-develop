require "test_helper"

class Admin::Forms::Alerts::AlertComponentTest < ActiveSupport::TestCase
  include ActionView::Component::TestHelpers

  test "component" do
    component = render_inline(Admin::Forms::Alerts::AlertComponent, alert: 'Test', type: 'danger')

    alert = component.css("div.alert-solid-danger")
    assert alert.any?
    assert_equal alert.css('div.alert-text').text, 'Test'
    assert alert.css('div.alert-close').any?
  end

end
