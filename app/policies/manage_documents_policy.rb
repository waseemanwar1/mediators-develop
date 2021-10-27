class ManageDocumentsPolicy < Struct.new(:user, :manage)

  def manage?
    CurrentAdmin.user = user
    CurrentAdmin.has_permission? "manage_documents"
  end
end
