class ManageApiPolicy < Struct.new(:user, :manage)

  def manage?
    CurrentAdmin.user = user
    CurrentAdmin.has_permission? 'manage_api'
  end
end
