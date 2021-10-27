class Admin::CasesController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params[:case][:tags] = eval(params[:case][:tags]).map { |pr| pr[:value] } if params[:case] && params[:case][:tags].present?
    params.permit(case:
      [
        :admin_user_id,
        :program,
        :name,
        :description,
        :status,
        tags: []
      ]
    )
  end
end
