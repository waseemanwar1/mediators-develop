class SendPinMailer < ApplicationMailer
  def send_message(user_id, url, pin)
    @url, @pin = url, pin
    mail(to: Party.find(user_id).email, subject: 'Signature mail')
  end
end
