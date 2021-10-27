class Admin::Api::V1::SessionController < Devise::SessionsController
  include Tokenizable

  skip_before_action :verify_authenticity_token

  def sign_in
    user = AdminUser.find_for_database_authentication(email: params[:admin_user][:email])

    if user && user.active && user.valid_password?( String(params[:admin_user][:password]) )
      render json: payload(user)
    elsif !user.active
      render json: {
        errors: ['User is not active']
      }, status: :unauthorized
    else
      render json: {
        errors: ['Invalid Email/Password']
      }, status: :unauthorized
    end
  end

end
