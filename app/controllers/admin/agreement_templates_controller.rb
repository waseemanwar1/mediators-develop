class Admin::AgreementTemplatesController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params.permit(agreement_template:
      [
        :name,
        :content,
        :public,
      ]
    )
  end
end
