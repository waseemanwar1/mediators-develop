class ContactSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :contact_type,
              :email, :title, :company,
              :phone, :address, :notes,
              :street, :city, :state,
              :zip_code, :country, :tags,
              :created_at, :updated_at

  attribute :admin_user do |object|
    AdminUserSerializer.new(object.admin_user, { fields: { admin_user: [:first_name, :last_name] } }).serializable_hash
  end

  attribute :cases do |object|
    CaseSerializer.new(object.cases, { fields: { case: [:name] } }).serializable_hash
  end

  attribute :parties do |object|
    PartySerializer.new(object.parties, { fields: { party: [:first_name, :last_name] } }).serializable_hash
  end
end
