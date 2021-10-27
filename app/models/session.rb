# id: integer
# admin_user: references
# case: references
# party: references
# name: string
# due_date: date
# time_start: time
# time_finish: time
# session_type: integer
# location: string
# tags: array
# rate_type: enum
# rate: integer
# created_at: datetime
# updated_at: datetime
class Session < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:name]
  enum session_type: ["Online", "Offline"]
  enum rate_type: ["Hourly", "Weekly"]

  # == Relationships ========================================================
  belongs_to :admin_user
  belongs_to :case
  belongs_to :party

  # == Validations ==========================================================
  validates_presence_of :name

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def to_s; name; end

  def search_data
    {
      sid: sid,
      updated_at: updated_at,
      created_at: created_at,
      admin_user_id: admin_user_id,
      case_id: case_id,
      party_id: party_id,
      name: name,
      due_date: due_date,
      time_start: time_start,
      time_finish: time_finish,
      session_type: session_type,
      location: location,
      rate_type: rate_type,
      rate: rate,
    }
  end
end
