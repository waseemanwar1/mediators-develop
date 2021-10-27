class Admin::InvoicesController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params.permit(invoice:
      [
        :admin_user_id,
        :case_id,
        :party_id,
        :name,
        :time,
        :amount,
        :date,
        :due_date,
        :status,
        :description
      ]
    )
  end
end
