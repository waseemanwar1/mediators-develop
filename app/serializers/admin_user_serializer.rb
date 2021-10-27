class AdminUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name, :hourly_rate,
              :company_name, :phone, :company_website,
              :address_line_1, :address_line_2, :postcode,
              :city, :state, :country,
              :billing_address_line_1, :billing_address_line_2, :billing_postcode,
              :billing_city, :billing_state, :billing_country,
              :subscription_paid, :stripe_subscription_id, :stripe_product_id,
              :created_at, :updated_at, :billing_type

  attribute :avatar do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.avatar) if object.avatar.attached?
  end
end
