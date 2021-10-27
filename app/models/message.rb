# id: integer
# admin_user: references
# case: references
# party: references
# subject: string
# sent_at: datetime
# content: text
# from: string
# to: string
# read: boolean
# created_at: datetime
# updated_at: datetime
class Message < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:subject, :content]

  # == Relationships ========================================================
  belongs_to :admin_user
  belongs_to :case
  belongs_to :party

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  # before_create :prepare
  # after_create :send_message

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def to_s; name; end

  # def prepare
  #   self.subject = "Case: #{self.case_id}, #{self.admin_user.username} message."
  #   self.from = self.admin_user.email
  #   self.to = self.party.email
  # end

  # def send_message
  #   MessageMailer.send_message(self.id).deliver_later
  # end

  def search_data
    {
      sid: sid,
      updated_at: updated_at,
      created_at: created_at,
      admin_user_id: admin_user_id,
      case_id: case_id,
      party_id: party_id,
      subject: subject,
      sent_at: sent_at,
      content: content,
      read: read,
      from: from,
      to: to,
    }
  end
end
