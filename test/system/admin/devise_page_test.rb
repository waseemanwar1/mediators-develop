require "application_system_test_case"

class Admin::DevisePageTest < ApplicationSystemTestCase
  test "devise page check elements locale=en" do
    visit new_admin_user_session_path(locale: 'en')

    image_equal? find('div.kt-login-v2__logo img')[:src], 'logo-dark.png'
  end

  test "devise page check elements locale=ru" do
    visit new_admin_user_session_path(locale: 'ru')

    image_equal? find('div.kt-login-v2__logo img')[:src], 'logo-dark.png'
  end
end
