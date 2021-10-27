# id: integer
# key: string
# name: string
# description: text
# created_at: datetime
# updated_at: datetime
class Permission < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:name]
  translates :name, :description

  # == Relationships ========================================================
  has_and_belongs_to_many :groups

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
      description: translations.map(&:description)
    }
  end

  def permission_references
    admin_users = AdminUser.joins(:groups).where( groups: { id: groups.pluck(:id) } )
    {
      groups: ( groups ? { ids: groups.pluck(:id) } : nil ),
      admin_users: ( admin_users ? { ids: admin_users.pluck(:id) } : nil )
    }
  end
end
