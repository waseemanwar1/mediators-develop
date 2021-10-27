class ManagePermissionsPolicy < Struct.new(:user, :manage)

  def manage?
    CurrentAdmin.user = user
    CurrentAdmin.has_permission? 'permission_settings'
  end
end
