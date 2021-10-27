class ManageInvoicesPolicy < Struct.new(:user, :manage)

  def manage?
    CurrentAdmin.user = user
    CurrentAdmin.has_permission? "manage_invoices"
  end
end
