class ResetPasswordMailer < ApplicationMailer
  def send_message(user_id, token)
    @user = AdminUser.find(user_id)
    @token = token
    mail(to: @user.email, subject: 'Reset password instructions')
  end
end
