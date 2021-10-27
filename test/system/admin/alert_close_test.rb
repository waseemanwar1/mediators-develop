require "application_system_test_case"

class Admin::AlertCloseTest < ApplicationSystemTestCase
  test "alert close is work" do
    visit new_admin_user_session_path(locale: 'en')

    click_button('Sign In', exact: true)
    assert_selector "div.alert-text", text: 'Invalid'

    find(:css, 'i.la.la-close').click
    assert_no_selector "div.alert-text", text: 'Invalid'
  end
end
