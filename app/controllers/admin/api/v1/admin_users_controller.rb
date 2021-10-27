class Admin::Api::V1::AdminUsersController < Admin::Api::V1::ApiController
  inherit_resources
  include DefaultAdminApiMethods
  before_action :authenticate_request!
  respond_to :json

  def info
    render json: AdminUserSerializer.new(CurrentAdmin.user).serializable_hash
  end

  def update_info
    @admin_user = CurrentAdmin.user
    update!
  end

private
  def permitted_params
    params.permit( admin_user:
      [
        :email, :password, :password_confirmation,
        :avatar, :first_name, :last_name,
        :hourly_rate, :company_name, :phone,
        :company_website, :address_line_1, :address_line_2,
        :postcode, :city, :state,
        :country, :billing_address_line_1, :billing_address_line_2,
        :billing_postcode, :billing_city, :billing_state,
        :billing_country, :billing_type
      ]
    )
  end
end
