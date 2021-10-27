class ReminderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :priority,
              :due_date, :status

  attribute :admin_user do |object|
    AdminUserSerializer.new(object.admin_user, { fields: { admin_user: [:first_name, :last_name] } }).serializable_hash
  end

  attribute :case do |object|
    CaseSerializer.new(object.case, { fields: { case: [:name] } }).serializable_hash
  end

  attribute :party do |object|
    PartySerializer.new(object.party, { fields: { party: [:first_name, :last_name] } }).serializable_hash
  end

  attribute :contact do |object|
    ContactSerializer.new(object.contact, { fields: { contact: [:first_name, :last_name] } }).serializable_hash
  end
end
