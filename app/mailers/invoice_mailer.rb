class InvoiceMailer < ApplicationMailer
  def send_message(id, token)
    @party = Party.find(id)
    @token = token
    mail(to: @party.email, subject: 'Invoice')
  end
end
