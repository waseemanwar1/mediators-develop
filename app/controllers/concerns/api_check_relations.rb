module ApiCheckRelations
  extend ActiveSupport::Concern

private
  def check_case_update
    unless CurrentAdmin.user.cases.pluck(:id).include?(resource.case_id)
      render json: { error: "The case does not belong to this user" }, status: :bad_request
      return
    end
  end

  def check_case_create
    unless CurrentAdmin.user.cases.pluck(:id).include?(permitted_params[resource_class.class_name.underscore.to_sym][:case_id].to_i)
      render json: { error: "The case does not belong to this user" }, status: :bad_request
      return
    end
  end

  def check_party_update
    unless CurrentAdmin.user.parties.pluck(:id).include?(resource.party_id)
      render json: { error: "The party does not belong to this user" }, status: :bad_request
      return
    end
  end

  def check_party_create
    unless CurrentAdmin.user.parties.pluck(:id).include?(permitted_params[resource_class.class_name.underscore.to_sym][:party_id].to_i)
      render json: { error: "The party does not belong to this user" }, status: :bad_request
      return
    end
  end
end
