class Admin::GroupsController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params.permit(group:
      [ :name ]
    )
  end
end
