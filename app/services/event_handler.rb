class EventHandler
  def call(event)
    begin
      if event.type == "invoice.payment_failed"
        user = AdminUser.find_by(stripe_customer_id: event.data.object.customer)
        user.update(subscription_paid: false)
      elsif event.type == "payment_intent.canceled"
        invoice = Invoice.find_by(stripe_payment_intent_id: event.data.object.id)
        invoice.update(status: "Canceled")
      elsif event.type == "payment_intent.succeeded"
        invoice = Invoice.find_by(stripe_payment_intent_id: event.data.object.id)
        invoice.update(status: "Succeeded")
      elsif event.type == "payment_intent.payment_failed"
        invoice = Invoice.find_by(stripe_payment_intent_id: event.data.object.id)
        invoice.update(status: "Payment Failed")
      elsif event.type == "payment_intent.attached"
        invoice = Invoice.find_by(stripe_payment_intent_id: event.data.object.id)
        invoice.update(status: "Attached")
      end
    rescue JSON::ParserError => e
      raise
    rescue NoMethodError => e
    end
  end
end
