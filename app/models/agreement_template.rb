# id: integer
# name: string
# content: text
# public: boolean
# created_at: datetime
# updated_at: datetime
class AgreementTemplate < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:name]

  # == Relationships ========================================================

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
      name: name,
      public: self.public
    }
  end
end
