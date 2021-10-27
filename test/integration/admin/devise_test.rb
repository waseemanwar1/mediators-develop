require 'test_helper'

class Admin::DeviseTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Sign in tests begin
  test 'wrong sign in form actions locale=en' do
    get new_admin_user_session_path(locale: 'en')
    assert_response :success

    post admin_user_session_path(locale: 'en')
    assert_select("div.alert-text", text: 'Invalid Email or Password')

    post admin_user_session_path(locale: 'en'), params: { admin_user: { email: 'notadmin@example.com' } }
    assert_select("div.alert-text", text: 'Invalid Email or Password')

    post admin_user_session_path(locale: 'en'), params: { admin_user: { email: 'admin@example.com', password: 'wrong' } }
    assert_select("div.alert-text", text: 'Invalid Email or Password')
  end

  test 'wrong sign in form actions locale=ru' do
    get new_admin_user_session_path(locale: 'ru')
    assert_response :success

    post admin_user_session_path(locale: 'ru')
    assert_select("div.alert-text", text: 'Неверная почта или пароль')

    post admin_user_session_path(locale: 'ru'), params: { admin_user: { email: 'notadmin@example.com' } }
    assert_select("div.alert-text", text: 'Неверная почта или пароль')

    post admin_user_session_path(locale: 'ru'), params: { admin_user: { email: 'admin@example.com', password: 'wrong' } }
    assert_select("div.alert-text", text: 'Неверная почта или пароль')
  end

  test "success sign in actions" do
    get new_admin_user_session_path(locale: 'en')
    assert_response :success

    post admin_user_session_path(locale: 'en'), params: { admin_user: { email: 'admin@example.com', password: 'password' } }
    assert_response :found
    assert_redirected_to(admin_root_path)
  end
  # Sign in tests end

  # Sign up tests begin
  test 'wrong sign up form actions locale=en' do
    get new_admin_user_registration_path(locale: 'en')
    assert_response :success

    post admin_user_registration_path(locale: 'en')
    assert_select("div.alert-text", text: "Email can't be blankPassword can't be blank")

    post admin_user_registration_path(locale: 'en'), params: { admin_user: { email: 'newadmin@example.com' } }
    assert_select("div.alert-text", text: "Password can't be blank")

    post admin_user_registration_path(locale: 'en'), params: { admin_user: { email: 'newadmin@example.com', password: 'password', password_confirmation: 'pazzword' } }
    assert_select("div.alert-text", text: "Password Confirmation doesn't match Password")

    post admin_user_registration_path(locale: 'en'), params: { admin_user: { email: 'newadmin@example.com', password: 'wrong' } }
    assert_select("div.alert-text", text: 'Password is too short (minimum is 6 characters)')
  end

  test 'wrong sign up form actions locale=ru' do
    get new_admin_user_registration_path(locale: 'ru')
    assert_response :success

    post admin_user_registration_path(locale: 'ru')
    assert_select("div.alert-text", text: "Почта не может быть пустымПароль не может быть пустым")

    post admin_user_registration_path(locale: 'ru'), params: { admin_user: { email: 'newadmin@example.com' } }
    assert_select("div.alert-text", text: "Пароль не может быть пустым")

    post admin_user_registration_path(locale: 'ru'), params: { admin_user: { email: 'newadmin@example.com', password: 'password', password_confirmation: 'pazzword' } }
    assert_select("div.alert-text", text: "Подтверждение пароля не совпадает со значением поля Пароль")

    post admin_user_registration_path(locale: 'ru'), params: { admin_user: { email: 'newadmin@example.com', password: 'wrong' } }
    assert_select("div.alert-text", text: 'Пароль недостаточной длины (не может быть меньше 6 символа)')
  end

  test "success sign up actions" do
    get new_admin_user_registration_path(locale: 'en')
    assert_response :success

    post admin_user_registration_path(locale: 'en'), params: { admin_user: { email: 'newadmin@example.com', password: 'password', password_confirmation: 'password' } }
    assert_response :found
    assert_redirected_to(admin_root_path)
  end
  # Sign up tests end

  # Forgot tests begin
  test 'wrong forgot form actions locale=en' do
    get new_admin_user_password_path(locale: 'en')
    assert_response :success

    post admin_user_password_path(locale: 'en')
    assert_select("div.alert-text", text: "Email can't be blank")

    post admin_user_password_path(locale: 'en'), params: { admin_user: { email: 'noadmin@example.com' } }
    assert_select("div.alert-text", text: "Email not found")

    post admin_user_password_path(locale: 'en'), params: { admin_user: { email: 'admin@example.com' } }
    follow_redirect!
    assert_select("div.alert-text", text: "You will receive an email with instructions on how to reset your password in a few minutes")
  end

  test 'wrong forgot form actions locale=ru' do
    get new_admin_user_password_path(locale: 'ru')
    assert_response :success

    post admin_user_password_path(locale: 'ru')
    assert_select("div.alert-text", text: "Почта не может быть пустым")

    post admin_user_password_path(locale: 'ru'), params: { admin_user: { email: 'noadmin@example.com' } }
    assert_select("div.alert-text", text: "Почта не найден")

    post admin_user_password_path(locale: 'ru'), params: { admin_user: { email: 'admin@example.com' } }
    follow_redirect!
    assert_select("div.alert-text", text: "На ваш Email была отправленна инструкция для смены пароля")
  end

  test "success forgot actions" do
    get new_admin_user_password_path(locale: 'en')
    assert_response :success

    post admin_user_password_path(locale: 'en'), params: { admin_user: { email: 'admin@example.com' } }
    assert_redirected_to(new_admin_user_session_path)

    assert_equal Devise.mailer.deliveries.count, 1
    email = ActionMailer::Base.deliveries.last
    assert_equal ["no-reply@equisettle.com"], email.from
    assert_equal ["admin@example.com"], email.to
    assert_equal "Reset password instructions", email.subject
  end
  # Forgot tests end

  # Reset pasword tests begin
  test 'wrong reset password form actions locale=en' do
    token = AdminUser.first.send_reset_password_instructions

    get edit_admin_user_password_path(locale: 'en', reset_password_token: token)
    assert_response :success

    put admin_user_password_path(locale: 'en'), params: { admin_user: { reset_password_token: token } }
    assert_select("div.alert-text", text: "Password can't be blank")

    put admin_user_password_path(locale: 'en'), params: { admin_user: { password: 'password', password_confirmation: 'pazzword', reset_password_token: token } }
    assert_select("div.alert-text", text: "Password Confirmation doesn't match Password")

    put admin_user_password_path(locale: 'en'), params: { admin_user: { password: 'wrong', reset_password_token: token } }
    assert_select("div.alert-text", text: 'Password is too short (minimum is 6 characters)')
  end

  test 'wrong reset password form actions locale=ru' do
    token = AdminUser.first.send_reset_password_instructions

    get edit_admin_user_password_path(locale: 'en', reset_password_token: token)
    assert_response :success

    put admin_user_password_path(locale: 'ru'), params: { admin_user: { reset_password_token: token } }
    assert_select("div.alert-text", text: "Пароль не может быть пустым")

    put admin_user_password_path(locale: 'ru'), params: { admin_user: { password: 'password', password_confirmation: 'pazzword', reset_password_token: token } }
    assert_select("div.alert-text", text: "Подтверждение пароля не совпадает со значением поля Пароль")

    put admin_user_password_path(locale: 'ru'), params: { admin_user: { password: 'wrong', reset_password_token: token } }
    assert_select("div.alert-text", text: 'Пароль недостаточной длины (не может быть меньше 6 символа)')
  end

  test "success reset password actions" do
    token = AdminUser.first.send_reset_password_instructions

    get edit_admin_user_password_path(locale: 'en', reset_password_token: token)
    assert_response :success

    put admin_user_password_path(locale: 'en'), params: { admin_user: { password: 'password', password_confirmation: 'password', reset_password_token: token } }
    assert_redirected_to(admin_root_path)

    assert_equal Devise.mailer.deliveries.count, 1
    email = ActionMailer::Base.deliveries.last
    assert_equal ["no-reply@equisettle.com"], email.from
    assert_equal ["admin@example.com"], email.to
    # assert_equal "Reset password instructions", email.subject
  end
  # Reset pasword tests end

  # Edit password tests begin
  test "without access locale=en" do
    get new_admin_user_session_path(locale: 'en')
    get edit_admin_user_registration_path(locale: 'en')

    follow_redirect!
    assert_select("div.alert-text", text: "You need to sign in or sign up before continuing")
  end

  test "without access locale=ru" do
    get new_admin_user_session_path(locale: 'ru')
    get edit_admin_user_registration_path(locale: 'ru')

    follow_redirect!
    assert_select("div.alert-text", text: "Вы должны войти или зарегистрироваться перед тем, как продолжить")
  end

  test "wrong edit password actions locale=en" do
    sign_in admin_users(:admin)
    get edit_admin_user_registration_path(locale: 'en')

    assert_response :success

    put admin_user_registration_path(locale: 'en')
    assert_select("div.alert-text", text: "Current Password can't be blank")

    put admin_user_registration_path(locale: 'en'), params: { admin_user: { current_password: 'wrong' } }
    assert_select("div.alert-text", text: "Current Password is invalid")

    put admin_user_registration_path(locale: 'en'), params: { admin_user: { current_password: 'password', password: 'newpassword', password_confirmation: '' } }
    assert_select("div.alert-text", text: "Password Confirmation doesn't match Password")

    put admin_user_registration_path(locale: 'en'), params: { admin_user: { current_password: 'password', password: 'newpassword', password_confirmation: 'wrongnewpassword' } }
    assert_select("div.alert-text", text: "Password Confirmation doesn't match Password")
  end

  test "wrong edit password actions locale=ru" do
    sign_in admin_users(:admin)
    get edit_admin_user_registration_path(locale: 'ru')

    assert_response :success

    put admin_user_registration_path(locale: 'ru')
    assert_select("div.alert-text", text: "Действующий пароль не может быть пустым")

    put admin_user_registration_path(locale: 'ru'), params: { admin_user: { current_password: 'wrong' } }
    assert_select("div.alert-text", text: "Действующий пароль имеет неверное значение")

    put admin_user_registration_path(locale: 'ru'), params: { admin_user: { current_password: 'password', password: 'newpassword', password_confirmation: '' } }
    assert_select("div.alert-text", text: "Подтверждение пароля не совпадает со значением поля Пароль")

    put admin_user_registration_path(locale: 'ru'), params: { admin_user: { current_password: 'password', password: 'newpassword', password_confirmation: 'wrongnewpassword' } }
    assert_select("div.alert-text", text: "Подтверждение пароля не совпадает со значением поля Пароль")
  end

  test "success edit password actions locale=en" do
    sign_in admin_users(:admin)
    get edit_admin_user_registration_path(locale: 'en')

    assert_response :success

    put admin_user_registration_path(locale: 'en'), params: { admin_user: { current_password: 'password' } }
    follow_redirect!
    assert_select("div.alert-text", text: "Your password has been updated successfully")

    put admin_user_registration_path(locale: 'en'), params: { admin_user: { current_password: 'password', password: 'newpassword', password_confirmation: 'newpassword' } }
    follow_redirect!
    assert_select("div.alert-text", text: "Your password has been updated successfully")
  end

  test "success edit password actions locale=ru" do
    sign_in admin_users(:admin)
    get edit_admin_user_registration_path(locale: 'ru')

    assert_response :success

    put admin_user_registration_path(locale: 'ru'), params: { admin_user: { current_password: 'password' } }
    follow_redirect!
    assert_select("div.alert-text", text: "Ваш пароль успешно обновлен")

    put admin_user_registration_path(locale: 'ru'), params: { admin_user: { current_password: 'password', password: 'newpassword', password_confirmation: 'newpassword' } }
    follow_redirect!
    assert_select("div.alert-text", text: "Ваш пароль успешно обновлен")
  end
  # Edit password tests end
end
