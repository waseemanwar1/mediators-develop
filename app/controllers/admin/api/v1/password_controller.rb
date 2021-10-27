class Admin::Api::V1::PasswordController < Devise::PasswordsController
  include Tokenizable

  skip_before_action :verify_authenticity_token

  def forgot
    user = AdminUser.find_by_email(params[:admin_user][:email])
    if user.present?
      key, hash = Devise.token_generator.generate(AdminUser, :reset_password_token)
      user.reset_password_token = hash
      user.reset_password_sent_at = Time.now
      user.save
      ResetPasswordMailer.send_message(user.id, key).deliver_later
      render json: { result: 'Success' }
    else
      render json: { result: 'Email not found' }, status: :not_found
    end
  end

  def reset
    if request.headers[:token].blank? || password_params[:admin_user][:password].blank? || password_params[:admin_user][:password_confirmation].blank?
      return render json: { error: 'Bad request' }, status: :bad_request
    end

    user = resource_class.reset_password_by_token(
      reset_password_token: request.headers[:token],
      password: password_params[:admin_user][:password],
      password_confirmation: password_params[:admin_user][:password_confirmation]
    )

    if user.errors.empty?
      return render json: { status: 'success' }, status: :ok
    else
      return render json: { errors: user.errors }, status: :bad_request
    end
  end

private
  def password_params
    params.permit( admin_user: [
      :password, :password_confirmation
    ])
  end
end
