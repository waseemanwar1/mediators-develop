# id: integer
# admin_user: references
# case: habtm
# party: habtm
# first_name: string
# last_name: string
# contact_type: string
# email: string
# title: string
# company: string
# phone: string
# address: string
# notes: text
# street: string
# city: string
# state: string
# zip_code: string
# country: string
# tags: array
# created_at: datetime
# updated_at: datetime
class Contact < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [
    :first_name, :last_name, :contact_type,
    :email, :title
  ]

  # == Relationships ========================================================
  belongs_to :admin_user
  has_and_belongs_to_many :cases
  has_and_belongs_to_many :parties

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def to_s; username; end

   def username
     "#{first_name} #{last_name}"
   end

  def search_data
    {
      sid: sid,
      updated_at: updated_at,
      created_at: created_at,
      admin_user_id: admin_user_id,
      cases: cases,
      parties: parties,
      first_name: first_name,
      last_name: last_name,
      contact_type: contact_type,
      email: email,
      title: title,
      tags: tags,
    }
  end
end
