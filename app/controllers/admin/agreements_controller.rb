class Admin::AgreementsController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params.permit(agreement:
      [
        :admin_user_id,
        :case_id,
        :agreement_template_id,
        :name,
        :content,
      ]
    )
  end
end
