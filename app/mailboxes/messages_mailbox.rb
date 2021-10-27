class MessagesMailbox < ApplicationMailbox
  def process
    # Case: 19, Test Mediator message.
    case_id = mail.subject[/Case\:(.*?)\,/,1].to_i
    m_case = Case.find(case_id)
    party = Party.find_by(email: mail.from.first)

    message = Message.create(
      subject: mail.subject,
      sent_at: mail.date,
      content: mail.body,
      from: mail.from.first,
      to: mail.to.first,
      admin_user_id: m_case.admin_user_id,
      case_id: m_case.id,
      party_id: party.id
    )
  end
end
