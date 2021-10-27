# id: integer
# admin_user: references
# case: references
# party: references
# contact: references
# name: string
# description: text
# priority: enum
# due_date: date
# status: enum
# created_at: datetime
# updated_at: datetime
class Reminder < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:name, :description]
  enum priority: ["Important", "No Matter"]
  enum status: ["Active", "Archive"]

  # == Relationships ========================================================
  belongs_to :admin_user
  belongs_to :case
  belongs_to :party
  belongs_to :contact, optional: true

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
      contact_id: contact_id,
      name: name,
      description: description,
      priority: priority,
      status: status,
      due_date: due_date
    }
  end
end
