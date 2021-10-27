# id: integer
# email: string
# encrypted_password: string
# reset_password_token: string
# reset_password_sent_at: datetime
# remember_created_at: datetime
# first_name: string
# last_name: string
# hourly_rate: integer
# company_name: string
# phone: string
# company_website: string
# address_line_1: string
# address_line_2: string
# postcode: string
# city: string
# state: string
# country: string
# billing_address_line_1: string
# billing_address_line_2: string
# billing_postcode: string
# billing_city: string
# billing_state: string
# billing_country: string
# stripe_customer_id: string
# subscription_paid: boolean
# stripe_product_id: string
# stripe_subscription_id: string
# stripe_connected_account_id: string
# created_at: datetime
# updated_at: datetime
# active: boolean
# billing_type: integer
class AdminUser < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  searchkick word_start: [:first_name, :last_name, :email]

  # == Relationships ========================================================
  has_one_attached :avatar
  has_and_belongs_to_many :groups
  has_many :agreements
  has_many :cases
  has_many :contacts
  has_many :documents
  has_many :invoices
  has_many :issues
  has_many :messages
  has_many :parties
  has_many :reminders
  has_many :sessions

  # == Validations ==========================================================

  # == Scopes ===============================================================
  scope :active, -> { where( active: true ) }
  scope :mediators, -> { joins(:groups).where( groups: { id: Group.where(name: 'Mediator').ids } ) }

  # == Callbacks ============================================================
  before_create :create_stripe_customer_account

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def to_s; username; end

  def username
    "#{first_name} #{last_name}"
  end

  def search_data
  {
    sid: sid,
    first_name: first_name,
    last_name: last_name,
    username: username,
    email: email,
    updated_at: updated_at,
    group_ids: groups.pluck(:id).map(&:to_s)
  }
  end

  def permission_references
    permissions = Permission.joins(:groups).where( groups: { id: groups.pluck(:id) } )
    {
      groups: ( groups ? { ids: groups.pluck(:id), names: groups.map(&:name) } : nil ),
      permissions: ( permissions ? { ids: permissions.pluck(:id) } : nil )
    }
  end

  def plan
    Stripe::Plan.retrieve(stripe_product_id).name rescue 'No subscription'
  end

  def next_pay
    begin
      invoice = Stripe::Invoice.upcoming(subscription: stripe_subscription_id)
      Time.at(invoice[:created]).strftime("%B %d, %Y")
    rescue
      'No subscription'
    end
  end

private
  def create_stripe_customer_account
    begin
      self.stripe_customer_id = Stripe::Customer.create(email: self.email).id
    rescue => e
      errors[:base] << e
      return false
    end
  end
end
