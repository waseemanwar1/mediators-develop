class ManageAgreementTemplatesPolicy < Struct.new(:user, :manage)

  def manage?
    CurrentAdmin.user = user
    CurrentAdmin.has_permission? "manage_agreement_templates"
  end
end
