class Admin::IssuesController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params.permit(issue:
      [
        :admin_user_id,
        :case_id,
        :party_id,
        :title,
        :description,
        :resolution_title,
        :resolution_description,
        :mediators_notes_title,
        :mediators_notes_description,
        :agreement,
      ]
    )
  end
end
