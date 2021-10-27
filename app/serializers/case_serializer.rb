class CaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :program, :name, :description,
              :tags, :status, :created_at, :updated_at

  attribute :admin_user do |object|
    AdminUserSerializer.new(object.admin_user, { fields: { admin_user: [:first_name, :last_name] } }).serializable_hash
  end

  attribute :parties do |object|
    PartySerializer.new(object.parties, { fields: { party: [:first_name, :last_name] } }).serializable_hash
  end
end
