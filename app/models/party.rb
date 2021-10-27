# id: integer
# admin_user: references
# case: references
# first_name: string
# last_name: string
# title: string
# company: string
# address: string
# notes: text
# email: string
# phone: string
# street: string
# city: string
# state: string
# zip_code: string
# country: string
# tags: array
# pdcflow_signature_id: string
# pdcflow_signature_link: text
# pdcflow_verification_pin: string
# pdcflow_status: string
# created_at: datetime
# updated_at: datetime
class Party < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:first_name, :last_name, :title, :email, :phone]

  # == Relationships ========================================================
  belongs_to :admin_user
  belongs_to :case
  has_and_belongs_to_many :contacts

  # == Validations ==========================================================
  validates_presence_of :first_name, :last_name, :email

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def to_s; "#{first_name} #{last_name}"; end

  def search_data
    {
      sid: sid,
      updated_at: updated_at,
      created_at: created_at,
      admin_user_id: admin_user_id,
      case_id: case_id,
      first_name: first_name,
      last_name: last_name,
      title: title,
      email: email,
      phone: phone
    }
  end
end
