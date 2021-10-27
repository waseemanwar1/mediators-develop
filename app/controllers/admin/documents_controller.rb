class Admin::DocumentsController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params.permit(document:
      [
        :admin_user_id,
        :case_id,
        :file_name,
        :description,
        :date,
        :author,
        :file
      ]
    )
  end
end
