require "application_system_test_case"

class Admin::SettingsWrapperTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "settings wrapper works" do
    sign_in admin_users(:admin)
    visit admin_root_url(locale: 'en')
    find('span', text: 'My Account').click

    assert_selector "a.kt-nav__link span.kt-nav__link-text", text: 'My Profile'
    assert_selector "a.kt-nav__link span.kt-nav__link-text", text: 'Change Password'
    assert_selector "a.kt-nav__link span.kt-nav__link-text", text: 'Settings'
    assert_selector "a", text: 'SIGN OUT'
  end
end
