require 'test_helper'

class Admin::DeviseTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'wrong access locale=en' do
    get new_admin_user_session_path(locale: 'en')
    get admin_root_path(locale: 'en')
    assert_redirected_to(new_admin_user_session_path(locale: 'en'))
    follow_redirect!
    assert_select("div.alert-text", text: 'You need to sign in or sign up before continuing')
  end

  test 'wrong access locale=ru' do
    get new_admin_user_session_path(locale: 'ru')
    get admin_root_path(locale: 'ru')
    assert_redirected_to(new_admin_user_session_path(locale: 'ru'))
    follow_redirect!
    assert_select("div.alert-text", text: 'Вы должны войти или зарегистрироваться перед тем, как продолжить')
  end

  test 'success access locale=en' do
    sign_in admin_users(:admin)
    get admin_root_path(locale: 'en')
    assert_response :success
  end
end
