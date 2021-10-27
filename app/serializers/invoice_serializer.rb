class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :time, :amount,
              :date, :due_date, :status,
              :created_at, :updated_at, :description

  attribute :admin_user do |object|
    AdminUserSerializer.new(object.admin_user, { fields: { admin_user: [:first_name, :last_name] } }).serializable_hash
  end

  attribute :case do |object|
    CaseSerializer.new(object.case, { fields: { case: [:name] } }).serializable_hash
  end

  attribute :party do |object|
    PartySerializer.new(object.party, { fields: { party: [:first_name, :last_name] } }).serializable_hash
  end
end
