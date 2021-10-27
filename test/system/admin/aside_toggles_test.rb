require "application_system_test_case"

class Admin::AsideTogglesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "toggle button is work and save state" do
    sign_in admin_users(:admin)
    visit admin_root_url(locale: 'en')

    find('#kt_aside_toggler',:visible => true).click

    visit admin_root_url(locale: 'en')
    assert_selector "body.kt-aside--minimize"
  end
end
