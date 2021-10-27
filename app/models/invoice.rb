# id: integer
# admin_user: references
# case: references
# party: references
# name: string
# time: integer
# amount: integer
# date: date
# due_date: date
# status: enum
# created_at: datetime
# updated_at: datetime
# stripe_payment_intent_id: string
# stripe_client_secret: string
# description: text
class Invoice < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:name]
  enum status: ["Created", "Canceled", "Succeeded", "Payment Failed"]

  # == Relationships ========================================================
  belongs_to :admin_user
  belongs_to :case
  belongs_to :party

  # == Validations ==========================================================
  validates_presence_of :name

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  before_create :create_payment_intent
  after_create :send_message

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def to_s; name; end

  def create_payment_intent
    begin
      payment_intent = Stripe::PaymentIntent.create({
        payment_method_types: ['card'],
        amount: amount,
        currency: 'usd',
        application_fee_amount: amount/10,
        transfer_data: {
          destination: admin_user.stripe_connected_account_id,
        },
      })
      self.stripe_payment_intent_id = payment_intent.id
      self.stripe_client_secret = payment_intent.client_secret
      self.status = "Created"
    rescue => e
      errors[:base] << e
      return false
    end
  end

  def send_message
    token = JsonWebToken.encode({ invoice_id: self.id })
    InvoiceMailer.send_message(self.party_id, token).deliver_later
  end

  def search_data
    {
      sid: sid,
      updated_at: updated_at,
      created_at: created_at,
      admin_user_id: admin_user_id,
      case_id: case_id,
      party_id: party_id,
      name: name,
      status: status,
    }
  end
end
