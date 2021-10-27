class MessageMailer < ApplicationMailer
  def send_message(id)
    @message = Message.find(id)

    mail(
      reply_to: 'fce0e392d192e69a4770b22678e24790@inbound.postmarkapp.com',
      to: @message.to,
      subject: @message.subject
    )
  end
end
