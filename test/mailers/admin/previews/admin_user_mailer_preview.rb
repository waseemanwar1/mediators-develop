class AdminUserMailerPreview < ActionMailer::Preview
  def forgot_password
    admin = AdminUser.first

    Devise::Mailer.reset_password_instructions(admin, admin.instance_variable_get(:@raw_reset_password_token))
  end
end
