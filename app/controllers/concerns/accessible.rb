module Accessible
  extend ActiveSupport::Concern

  included do
    before_action :check_user
  end

protected
  def check_user
    if current_admin_user
      flash.clear
      redirect_to(admin_root_path(locale: params[:locale])) && return
    end
    # elsif current_user
    #   flash.clear
    #   redirect_to(authenticated_user_root_path) && return
    # end
  end
end
