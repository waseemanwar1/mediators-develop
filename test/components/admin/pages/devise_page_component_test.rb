require "test_helper"

class Admin::Pages::DevisePageComponentTest < ActiveSupport::TestCase
  include ActionView::Component::TestHelpers

  test "component locale=en" do
    I18n.locale = :en

    component = render_inline(Admin::Pages::DevisePageComponent, header_link: {
      text: I18n.t('admin.page.sign_in.sign_up_link'),
      path: '/admin/sign_up?locale=en'
    }) { 'ok' }

    header_link = component.css("a[href='/admin/sign_up?locale=en']")
    assert header_link.any?
    assert_equal header_link.text, 'Sign Up'

    footer_brand_link = component.css("div.kt-login-v2__info a")
    assert footer_brand_link.any?
    assert_equal footer_brand_link.text, '© 2018 KeenThemes'

    footer_support_link = component.css("div.kt-login-v2__link a")
    assert footer_support_link.any?
    assert_equal footer_support_link.text, 'Support'
  end

  test "component locale=ru" do
    I18n.locale = :ru

    component = render_inline(Admin::Pages::DevisePageComponent, header_link: {
      text: I18n.t('admin.page.sign_in.sign_up_link'),
      path: '/admin/sign_up?locale=ru'
    }) { 'ok' }

    header_link = component.css("a[href='/admin/sign_up?locale=ru']")
    assert header_link.any?
    assert_equal header_link.text, 'Регистрация'

    footer_brand_link = component.css("div.kt-login-v2__info a")
    assert footer_brand_link.any?
    assert_equal footer_brand_link.text, '© 2018 KeenThemes'

    footer_support_link = component.css("div.kt-login-v2__link a")
    assert footer_support_link.any?
    assert_equal footer_support_link.text, 'Поддержка'
  end

  test "without link" do
    I18n.locale = :en

    component = render_inline(Admin::Pages::DevisePageComponent) { 'ok' }

    footer_brand_link = component.css("div.kt-login-v2__info a")
    assert footer_brand_link.any?
    assert_equal footer_brand_link.text, '© 2018 KeenThemes'

    footer_support_link = component.css("div.kt-login-v2__link a")
    assert footer_support_link.any?
    assert_equal footer_support_link.text, 'Support'
  end
end
