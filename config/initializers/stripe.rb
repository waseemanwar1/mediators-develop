if Rails.env == 'production'
  Rails.configuration.stripe = {
    public_key: Equisettle::Application.credentials.stripe_production_public,
    secret_key: Equisettle::Application.credentials.stripe_production_secret,
    account_signing_secret: Equisettle::Application.credentials.stripe_production_account_signing_secret,
    connect_signing_secret: Equisettle::Application.credentials.stripe_production_connect_signing_secret,
    state: Equisettle::Application.credentials.stripe_production_state
  }
else
  Rails.configuration.stripe = {
    public_key: Equisettle::Application.credentials.stripe_development_public,
    secret_key: Equisettle::Application.credentials.stripe_development_secret,
    account_signing_secret: Equisettle::Application.credentials.stripe_development_account_signing_secret,
    connect_signing_secret: Equisettle::Application.credentials.stripe_development_connect_signing_secret,
    state: Equisettle::Application.credentials.stripe_development_state
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]

# StripeEvent.signing_secret = Rails.configuration.stripe[:signature]
StripeEvent.signing_secrets = [
  Rails.configuration.stripe[:account_signing_secret],
  Rails.configuration.stripe[:connect_signing_secret],
]
StripeEvent.configure do |events|
  events.all EventHandler.new
end
