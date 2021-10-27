class Admin::RemindersController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params.permit(reminder:
      [
        :admin_user_id,
        :case_id,
        :party_id,
        :name,
        :description,
        :priority,
        :due_date,
        :contact_id,
        :status,
      ]
    )
  end
end
