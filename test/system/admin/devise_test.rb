require "application_system_test_case"

class Admin::DeviseTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  # Sign in test begin
  test "sign in check elements locale=en" do
    visit new_admin_user_session_path(locale: 'en')
    image_equal? find('div.kt-login-v2__image img')[:src], 'signin-background.svg'
  end
  # Sign in test end

  # Sign up test begin
  test "sign up check elements locale=en" do
    visit new_admin_user_registration_path(locale: 'en')
    image_equal? find('div.kt-login-v2__image img')[:src], 'signin-background.svg'
  end
  # Sign in test end
end
