class Admin::Api::V1::ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  attr_reader :current_admin_user

protected

  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = AdminUser.find(auth_token[:admin_user_id])
    unless @current_user.active
      render json: { errors: ['User is not active'] }, status: :unauthorized
      return
    end
    CurrentAdmin.user = @current_user
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

private
  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:admin_user_id].to_i
  end
end
