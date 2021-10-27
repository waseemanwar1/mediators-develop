# id: integer
# name: string
# created_at: datetime
# updated_at: datetime
class Group < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:name]
  translates :name

  # == Relationships ========================================================
  has_and_belongs_to_many :admin_users
  has_and_belongs_to_many :permissions

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
      name: translations.map(&:name),
      updated_at: updated_at
    }
  end

  def permission_references
    {
      permissions: ( permissions ? { ids: permissions.pluck(:id), names: permissions.pluck(:name) } : nil ),
      admin_users: ( admin_users ? { ids: admin_users.pluck(:id), names: admin_users.map(&:username) } : nil )
    }
  end
end
