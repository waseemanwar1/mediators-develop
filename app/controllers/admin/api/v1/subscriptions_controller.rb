class Admin::Api::V1::SubscriptionsController < Admin::Api::V1::ApiController
  before_action :authenticate_request!

  def index
    begin
      stripe_list = Stripe::Plan.list
      plans = stripe_list[:data]
      render json: plans.to_json, status: :ok
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end
  end

  def show_payment_method
    begin
      default_payment_method = Stripe::Customer.retrieve(CurrentAdmin.user.stripe_customer_id).invoice_settings.default_payment_method
      payment_method = Stripe::PaymentMethod.retrieve(default_payment_method)
      render json: payment_method.to_json, status: :ok
    rescue => e
      render json: { error: e }, status: 400
      return
    end
  end

  def create
    # Find or create the payment method
    begin
      payment_method = Stripe::PaymentMethod.attach( params[:payment_method_id], { customer: CurrentAdmin.user.stripe_customer_id } )
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end

    # Update customer payment method
    begin
      Stripe::Customer.update(
        CurrentAdmin.user.stripe_customer_id,
        invoice_settings: {
          default_payment_method: payment_method.id
        }
      )
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end

    # Create the subscription
    begin
      subscription = Stripe::Subscription.create({
        customer: CurrentAdmin.user.stripe_customer_id,
        items: [
          { price: params[:plan_id] }
        ],
        expand: ['latest_invoice.payment_intent']
      })
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end

    # Save stripe info to the user
    CurrentAdmin.user.update(
      stripe_subscription_id: subscription.id,
      stripe_product_id: params[:plan_id],
      subscription_paid: subscription.latest_invoice.payment_intent.status == "succeeded"
    )
    render json: subscription.to_json, status: :ok
  end

  def update_plan
    begin
      subscription = Stripe::Subscription.retrieve(CurrentAdmin.user.stripe_subscription_id)
    rescue => e
      render json: { error: e }, status: 400
      return
    end

    begin
      updated_subscription = Stripe::Subscription.update(
        CurrentAdmin.user.stripe_subscription_id,
        {
          cancel_at_period_end: false,
          items: [
            {
              id: subscription.items.data[0].id,
              price: params[:plan_id],
            },
          ],
        }
      )
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end

    render json: updated_subscription.to_json, status: :ok
  end

  def retry
    # Find or create the payment method
    begin
      payment_method = Stripe::PaymentMethod.attach( params[:payment_method_id], { customer: CurrentAdmin.user.stripe_customer_id } )
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end

    # Update customer payment method
    begin
      Stripe::Customer.update(
        CurrentAdmin.user.stripe_customer_id,
        invoice_settings: {
          default_payment_method: payment_method.id
        }
      )
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end

    # Retrive subscription
    begin
      subscription = Stripe::Subscription.retrieve(CurrentAdmin.user.stripe_subscription_id)
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end

    # Retrieve invoice
    begin
      invoice = Stripe::Invoice.retrieve({
        id: subscription.latest_invoice,
        expand: ['payment_intent']
      })
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end

    # Save stripe info to the user
    CurrentAdmin.user.update(
      subscription_paid: invoice.payment_intent.status == "succeeded"
    )
    render json: invoice.to_json, status: :ok
  end

  def unsubscribe
    # Unsubscribe
    begin
      deleted_subscription = Stripe::Subscription.delete(CurrentAdmin.user.stripe_subscription_id)
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end

    # Clear subscription data
    CurrentAdmin.user.update(
      stripe_subscription_id: nil,
      stripe_product_id: nil,
      subscription_paid: false
    )

    render json: deleted_subscription.to_json, status: :ok
  end

  def history
    begin
      stripe_list = Stripe::InvoiceItem.list({
        customer: CurrentAdmin.user.stripe_customer_id,
        limit: 10
      })
      invoices = stripe_list[:data]
      render json: invoices.to_json, status: :ok
    rescue => e
      render json: { error: e.error.message }, status: 400
      return
    end
  end
end
