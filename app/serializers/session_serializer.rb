class SessionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :due_date, :time_start,
              :time_finish, :session_type, :location,
              :tags, :rate_type, :rate

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
