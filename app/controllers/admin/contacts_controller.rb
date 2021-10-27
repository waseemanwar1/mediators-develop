class Admin::ContactsController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params[:contact][:tags] = eval(params[:contact][:tags]).map { |pr| pr[:value] } if params[:contact] && params[:contact][:tags].present?
    params.permit(contact:
      [
        :admin_user_id,
        :first_name,
        :last_name,
        :contact_type,
        :email,
        :title,
        :company,
        :phone,
        :address,
        :notes,
        :street,
        :city,
        :state,
        :zip_code,
        :country,
        tags: [],
        case_ids: [],
        party_ids: []
      ]
    )
  end
end
