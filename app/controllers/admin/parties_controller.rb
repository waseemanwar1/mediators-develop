class Admin::PartiesController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params[:party][:tags] = eval(params[:party][:tags]).map { |pr| pr[:value] } if params[:party] && params[:party][:tags].present?
    params.permit(party:
      [
        :admin_user_id,
        :case_id,
        :first_name,
        :last_name,
        :title,
        :company,
        :address,
        :notes,
        :email,
        :phone,
        :street,
        :city,
        :state,
        :zip_code,
        :country,
        tags: []
      ]
    )
  end
end
