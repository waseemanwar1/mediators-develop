# id: integer
# admin_user: references
# case: references
# file_name: string
# description: text
# date: date
# author: string
# created_at: datetime
# updated_at: datetime
class Document < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id
  has_one_attached :file

  # == Extensions ===========================================================
  searchkick word_start: [:file_name, :description]

  # == Relationships ========================================================
  belongs_to :admin_user
  belongs_to :case

  # == Validations ==========================================================
  validates_presence_of :file_name

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
      file_name: file_name,
      description: description,
    }
  end
end
