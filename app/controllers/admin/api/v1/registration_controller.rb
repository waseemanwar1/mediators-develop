class Admin::Api::V1::RegistrationController < Devise::RegistrationsController
  include Tokenizable

  skip_before_action :verify_authenticity_token

  def sign_up
    build_resource(admin_user_params[:admin_user])

    if resource.save
      render json: payload(resource), status: :created
    else
      render json: { errors: resource.errors.full_messages }, status: :unauthorized
    end
  end

private
  def admin_user_params
    params.permit(admin_user: [
       :email, :password, :password_confirmation
    ])
  end
end
