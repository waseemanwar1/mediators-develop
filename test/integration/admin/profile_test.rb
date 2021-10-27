require 'test_helper'

class Admin::ProfileTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Edit profile tests begin
  test "edit without access locale=en" do
    get new_admin_user_session_path(locale: 'en')
    get my_admin_profile_path(locale: 'en')

    follow_redirect!
    assert_select("div.alert-text", text: "You need to sign in or sign up before continuing")
  end

  test "edit without access locale=ru" do
    get new_admin_user_session_path(locale: 'ru')
    get my_admin_profile_path(locale: 'ru')

    follow_redirect!
    assert_select("div.alert-text", text: "Вы должны войти или зарегистрироваться перед тем, как продолжить")
  end

  test "wrong edit profile actions locale=en" do
    sign_in admin_users(:admin)
    get my_admin_profile_path(locale: 'en')

    assert_response :success

    put admin_profile_path(locale: 'en'), params: { admin_user: { email: '' } }
    follow_redirect!
    assert_select("div.alert-text", text: "Email can't be blank")

    put admin_profile_path(locale: 'en'), params: { admin_user: { email: 'admin2@example.com' } }
    follow_redirect!
    assert_select("div.alert-text", text: "Email has already been taken")
  end

  test "wrong edit profile actions locale=ru" do
    sign_in admin_users(:admin)
    get my_admin_profile_path(locale: 'ru')

    assert_response :success

    put admin_profile_path(locale: 'ru'), params: { admin_user: { email: '' } }
    follow_redirect!
    assert_select("div.alert-text", text: "Почта не может быть пустым")

    put admin_profile_path(locale: 'ru'), params: { admin_user: { email: 'admin2@example.com' } }
    follow_redirect!
    assert_select("div.alert-text", text: "Почта уже существует")
  end

  test "success edit profile actions locale=en" do
    sign_in admin_users(:admin)
    get my_admin_profile_path(locale: 'en')

    assert_response :success

    put admin_profile_path(locale: 'ru'), params: { admin_user: { email: 'newmail@example.com' } }
    follow_redirect!
    assert_select("input[id=admin_user_email]") do
      assert_select '[value=?]', 'newmail@example.com'
    end
  end
  # Edit profile tests end

  # Settings profile tests begin
  test "settings without access locale=en" do
    get new_admin_user_session_path(locale: 'en')
    get settings_admin_profile_path(locale: 'en')

    follow_redirect!
    assert_select("div.alert-text", text: "You need to sign in or sign up before continuing")
  end

  test "settings without access locale=ru" do
    get new_admin_user_session_path(locale: 'ru')
    get settings_admin_profile_path(locale: 'ru')

    follow_redirect!
    assert_select("div.alert-text", text: "Вы должны войти или зарегистрироваться перед тем, как продолжить")
  end

  test "success settings profile actions locale=en" do
    sign_in admin_users(:admin)
    get settings_admin_profile_path(locale: 'en')

    assert_response :success

    delete admin_user_registration_path(locale: 'en')
    assert_redirected_to('/')
  end
  # Settings profile tests end
end
