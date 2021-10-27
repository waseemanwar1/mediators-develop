# id: integer
# admin_user: references
# case: references
# party: references
# title: string
# description: text
# resolution_title: string
# resolution_description: text
# mediators_notes_title: string
# mediators_notes_description: text
# agreement: text
# created_at: datetime
# updated_at: datetime
class Issue < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:title, :description]

  # == Relationships ========================================================
  belongs_to :admin_user
  belongs_to :case
  belongs_to :party

  # == Validations ==========================================================
  validates_presence_of :title

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def to_s; title; end

  def search_data
    {
      sid: sid,
      updated_at: updated_at,
      created_at: created_at,
      admin_user_id: admin_user_id,
      case_id: case_id,
      party_id: party_id,
      title: title,
      description: description,
    }
  end
end
