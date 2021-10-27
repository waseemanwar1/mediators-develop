require "application_system_test_case"

class Admin::LogosTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "header has logo" do
    sign_in admin_users(:admin)
    visit admin_root_url(locale: 'en')

    image_equal? find('div.kt-aside__brand-logo img')[:src], 'logo.png'
  end
end
