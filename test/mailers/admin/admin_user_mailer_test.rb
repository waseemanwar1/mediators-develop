require "test_helper"

class AdminUserMailerTest < ActionMailer::TestCase
  test "reset password en" do
    I18n.locale = :en

    admin = AdminUser.last
    email = Devise::Mailer.reset_password_instructions(admin, admin.instance_variable_get(:@raw_reset_password_token)).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ["no-reply@equisettle.com"], email.from
    assert_equal [admin.email], email.to
    assert_equal "Reset password instructions", email.subject
  end

  test "reset password ru" do
    I18n.locale = :ru

    admin = AdminUser.last
    email = Devise::Mailer.reset_password_instructions(admin, admin.instance_variable_get(:@raw_reset_password_token)).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ["no-reply@equisettle.com"], email.from
    assert_equal [admin.email], email.to
    assert_equal "Инструкции для смены пароля", email.subject
  end
end
