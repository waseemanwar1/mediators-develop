require 'test_helper'

class Admin::ProfileControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Profile edit begin
  test "profile edit en" do
    sign_in admin_users(:admin)
    get my_admin_profile_path(locale: 'en')

    assert_response :success

    assert_select("li.kt-nav__item.active span.kt-nav__link-text", text: 'My Profile')

    assert_select("h3.kt-portlet__head-title", text: 'My Profilehere you can change your data')

    assert_select("div.form-group") do
      assert_select("label", text: "Email")
      assert_select("input[id=admin_user_email]") do
        assert_select '[type=?]', 'email'
        assert_select '[placeholder=?]', 'your-email@example.com'
        assert_select '[value=?]', admin_users(:admin).email
      end
    end

    assert_select("input[type=submit][value='Submit']")
    assert_select("button[type=reset]", "Cancel")
  end

  test "profile edit ru" do
    sign_in admin_users(:admin)
    get my_admin_profile_path(locale: 'ru')

    assert_response :success

    assert_select("li.kt-nav__item.active span.kt-nav__link-text", text: 'Мой Профиль')

    assert_select("h3.kt-portlet__head-title", text: 'Мой профильздесь вы можете изменить свои данные')

    assert_select("div.form-group") do
      assert_select("label", text: "Почта")
      assert_select("input[id=admin_user_email]") do
        assert_select '[type=?]', 'email'
        assert_select '[placeholder=?]', 'your-email@example.com'
        assert_select '[value=?]', admin_users(:admin).email
      end
    end

    assert_select("input[type=submit][value='Отправить']")
    assert_select("button[type=reset]", "Отмена")
  end
  # Profile edit end

  # Profile setings begin
  test "profile settings en" do
    sign_in admin_users(:admin)
    get settings_admin_profile_path(locale: 'en')

    assert_response :success

    assert_select("li.kt-nav__item.active span.kt-nav__link-text", text: 'Settings')

    assert_select("h3.kt-portlet__head-title", text: 'Settingshere you can set up your accout')

    assert_select("input[type=submit][value='Deactivate your account?']")
  end

  test "profile settings ru" do
    sign_in admin_users(:admin)
    get settings_admin_profile_path(locale: 'ru')

    assert_response :success

    assert_select("li.kt-nav__item.active span.kt-nav__link-text", text: 'Настройки')

    assert_select("h3.kt-portlet__head-title", text: 'Настройкиздесь вы можете настроить свой аккаунт')

    assert_select("input[type=submit][value='Удалить ваш аккаунт?']")
  end
  # Profile setings end
end
