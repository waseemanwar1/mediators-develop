# id: integer
# admin_user: references
# program: string
# name: string
# description: text
# tags: array
# status: enum
# created_at: datetime
# updated_at: datetime
class Case < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:name, :description]
  enum status: ["Active", "Not Active"]

  # == Relationships ========================================================
  belongs_to :admin_user
  has_many :parties
  has_and_belongs_to_many :contacts
  has_one :agreement
  has_many :issues

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
      name: name,
      description: description,
      status: status,
      party_ids: parties.pluck(:id)
    }
  end
end
