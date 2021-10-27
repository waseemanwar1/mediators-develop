class PartySerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :title,
              :company, :address, :notes,
              :email, :phone, :street,
              :city, :state, :zip_code,
              :country, :tags

  attribute :admin_user do |object|
    AdminUserSerializer.new(object.admin_user, { fields: { admin_user: [:first_name, :last_name] } }).serializable_hash
  end

  attribute :case do |object|
    CaseSerializer.new(object.case, { fields: { case: [:name] } }).serializable_hash
  end

  attribute :contacts do |object|
    ContactSerializer.new(object.contacts, { fields: { contact: [:first_name, :last_name, :contact_type] } }).serializable_hash
  end
end
