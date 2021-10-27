class Admin::SessionsController < Admin::AdminController
  inherit_resources
  include DefaultMethods

private
  def permitted_params
    params[:session][:tags] = eval(params[:session][:tags]).map { |pr| pr[:value] } if params[:session] && params[:session][:tags].present?
    params.permit(session:
      [
        :admin_user_id,
        :case_id,
        :party_id,
        :name,
        :due_date,
        :time_start,
        :time_finish,
        :session_type,
        :location,
        :rate_type,
        :rate,
        tags: []
      ]
    )
  end
end
