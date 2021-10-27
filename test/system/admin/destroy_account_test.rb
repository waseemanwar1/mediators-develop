require "application_system_test_case"

class Admin::DestroyAccountTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "destroy modal window is open locale=en" do
    sign_in admin_users(:admin)
    visit settings_admin_profile_path(locale: 'en')

    click_button('Deactivate your account?', exact: true)
    assert('Do you really want to delete your account?')
  end

  test "destroy modal window is open locale=ru" do
    sign_in admin_users(:admin)
    visit settings_admin_profile_path(locale: 'ru')

    click_button('Удалить ваш аккаунт?', exact: true)
    assert('Вы уверены что хотите удалить свой аккаунт?')
  end
end
