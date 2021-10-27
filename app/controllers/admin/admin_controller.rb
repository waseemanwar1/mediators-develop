class Admin::AdminController < ApplicationController
  layout 'admin'

  before_action :set_current, :check_user_groups

private
  def set_current
    CurrentAdmin.user = current_admin_user
    CurrentAdmin.request = request
  end

  def check_user_groups
    redirect_to "/" if CurrentAdmin.user.groups.count == 0
  end
end
