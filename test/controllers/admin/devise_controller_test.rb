require 'test_helper'

class Admin::DeviseControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Sign In tests begin
  test "sign in en" do
    get new_admin_user_session_path(locale: 'en')

    assert_response :success

    assert_select("h3", text: 'Sign to Admin')
    assert_select("a[href='/admin/password/new?locale=en']", text: 'Forgot Password ?')

    assert_select("input[id=admin_user_email]") do
      assert_select '[type=?]', 'email'
      assert_select '[placeholder=?]', 'Email'
    end

    assert_select("input[id=admin_user_password]") do
      assert_select '[type=?]', 'password'
      assert_select '[placeholder=?]', 'Password'
    end

    assert_select("input[type=submit][value='Sign In']")
  end

  test "sign in ru" do
    get new_admin_user_session_path(locale: 'ru')

    assert_response :success

    assert_select("h3", text: 'Вход администратора')
    assert_select("a[href='/admin/password/new?locale=ru']", text: 'Забыли пароль ?')

    assert_select("input[id=admin_user_email]") do
      assert_select '[type=?]', 'email'
      assert_select '[placeholder=?]', 'Почта'
    end

    assert_select("input[id=admin_user_password]") do
      assert_select '[type=?]', 'password'
      assert_select '[placeholder=?]', 'Пароль'
    end

    assert_select("input[type=submit][value='Вход']")
  end
  # Sign In tests end

  # Sign Up tests begin
  test "sign up en" do
    get new_admin_user_registration_path(locale: 'en')

    assert_response :success

    assert_select("h3", text: 'Sign Up for Admin')

    assert_select("input[id=admin_user_email]") do
      assert_select '[type=?]', 'email'
      assert_select '[placeholder=?]', 'Email'
    end

    assert_select("input[id=admin_user_password]") do
      assert_select '[type=?]', 'password'
      assert_select '[placeholder=?]', 'Password'
    end

    assert_select("span.form-text", text: '6 characters minimum')

    assert_select("input[id=admin_user_password_confirmation]") do
      assert_select '[type=?]', 'password'
      assert_select '[placeholder=?]', 'Password confirmation'
    end

    assert_select("input[type=submit][value='Sign Up']")
  end

  test "sign up ru" do
    get new_admin_user_registration_path(locale: 'ru')

    assert_response :success

    assert_select("h3", text: 'Регистрация администратора')

    assert_select("input[id=admin_user_email]") do
      assert_select '[type=?]', 'email'
      assert_select '[placeholder=?]', 'Почта'
    end

    assert_select("span.form-text", text: '6 символов минимум')

    assert_select("input[id=admin_user_password]") do
      assert_select '[type=?]', 'password'
      assert_select '[placeholder=?]', 'Пароль'
    end

    assert_select("input[id=admin_user_password_confirmation]") do
      assert_select '[type=?]', 'password'
      assert_select '[placeholder=?]', 'Подтверждение пароля'
    end

    assert_select("input[type=submit][value='Регистрация']")
  end
  # Sign Up tests end

  # Forgot tests begin
  test "forgot en" do
    get new_admin_user_password_path(locale: 'en')

    assert_response :success

    assert_select("h3", text: 'Forgot your password ?')

    assert_select("input[id=admin_user_email]") do
      assert_select '[type=?]', 'email'
      assert_select '[placeholder=?]', 'Email'
    end

    assert_select("input[type=submit][value='Send instructions']")
  end

  test "forgot ru" do
    get new_admin_user_password_path(locale: 'ru')

    assert_response :success

    assert_select("h3", text: 'Забыли пароль ?')

    assert_select("input[id=admin_user_email]") do
      assert_select '[type=?]', 'email'
      assert_select '[placeholder=?]', 'Почта'
    end

    assert_select("input[type=submit][value='Отправить инструкции']")
  end
  # Forgot tests end

  # Reset password tests begin
  test "reset password en" do
    token = AdminUser.first.send_reset_password_instructions

    get edit_admin_user_password_path(locale: 'en', reset_password_token: token)

    assert_response :success

    assert_select("h3", text: 'Change your password')

    assert_select("input[id=admin_user_password]") do
      assert_select '[type=?]', 'password'
      assert_select '[placeholder=?]', 'New Password'
    end

    assert_select("input[id=admin_user_password_confirmation]") do
      assert_select '[type=?]', 'password'
      assert_select '[placeholder=?]', 'New Password confirmation'
    end

    assert_select("input[type=submit][value='Change password']")
  end

  test "reset password ru" do
    token = AdminUser.first.send_reset_password_instructions

    get edit_admin_user_password_path(locale: 'ru', reset_password_token: token)

    assert_response :success

    assert_select("h3", text: 'Измените пароль')

    assert_select("input[id=admin_user_password]") do
      assert_select '[type=?]', 'password'
      assert_select '[placeholder=?]', 'Новый пароль'
    end

    assert_select("input[id=admin_user_password_confirmation]") do
      assert_select '[type=?]', 'password'
      assert_select '[placeholder=?]', 'Подтвеждение нового пароля'
    end

    assert_select("input[type=submit][value='Изменить пароль']")
  end
  # Reset password tests end

  # Password edit begin
  test "password edit en" do
    sign_in admin_users(:admin)
    get edit_admin_user_registration_path(locale: 'en')

    assert_response :success

    assert_select("li.kt-nav__item.active span.kt-nav__link-text", text: 'Change Password')

    assert_select("h3.kt-portlet__head-title", text: 'Change passwordhere you can change your password')

    assert_select("div.form-group") do
      assert_select("label", text: "Current Password")
      assert_select("input[id=admin_user_current_password]") do
        assert_select '[type=?]', 'password'
      end
    end

    assert_select("div.form-group") do
      assert_select("label", text: "New Password")
      assert_select("input[id=admin_user_password]") do
        assert_select '[type=?]', 'password'
      end
    end

    assert_select("div.form-group") do
      assert_select("label", text: "Verify Password")
      assert_select("input[id=admin_user_password_confirmation]") do
        assert_select '[type=?]', 'password'
      end
    end

    assert_select("input[type=submit][value='Change Password']")
    assert_select("button[type=reset]", "Cancel")
  end

  test "password edit ru" do
    sign_in admin_users(:admin)
    get edit_admin_user_registration_path(locale: 'ru')

    assert_response :success

    assert_select("li.kt-nav__item.active span.kt-nav__link-text", text: 'Изменить Пароль')

    assert_select("h3.kt-portlet__head-title", text: 'Изменить парольздесь вы можете изменить свой пароль')

    assert_select("div.form-group") do
      assert_select("label", text: "Действующий пароль")
      assert_select("input[id=admin_user_current_password]") do
        assert_select '[type=?]', 'password'
      end
    end

    assert_select("div.form-group") do
      assert_select("label", text: "Новый пароль")
      assert_select("input[id=admin_user_password]") do
        assert_select '[type=?]', 'password'
      end
    end

    assert_select("div.form-group") do
      assert_select("label", text: "Подтверите новый пароль")
      assert_select("input[id=admin_user_password_confirmation]") do
        assert_select '[type=?]', 'password'
      end
    end

    assert_select("input[type=submit][value='Изменить пароль']")
    assert_select("button[type=reset]", "Отмена")
  end
  # Password edit end
end
