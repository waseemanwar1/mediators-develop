class AgreementSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :content, :created_at, :updated_at

  attribute :admin_user do |object|
    AdminUserSerializer.new(object.admin_user, { fields: { admin_user: [:first_name, :last_name] } }).serializable_hash
  end

  attribute :case do |object|
    CaseSerializer.new(object.case, { fields: { case: [:name] } }).serializable_hash
  end

  attribute :file do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.file) if object.file.attached?
  end
end
