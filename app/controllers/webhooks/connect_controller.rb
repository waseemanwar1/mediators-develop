class Webhooks::ConnectController < ApplicationController
  def oauth
    state = params[:state]
    if !state_matches?(state)
      flash[:errors] = ['Incorrect state parameter: ' + state]
    end

    code = params[:code]
    begin
      response = Stripe::OAuth.token({
        grant_type: 'authorization_code',
        code: code,
      })
    rescue Stripe::OAuth::InvalidGrantError
      flash[:errors] = ['Invalid authorization code: ' + code]
    rescue Stripe::StripeError
      flash[:errors] = ['An unknown error occurred.']
    end

    # begin
    #   account = Stripe::Account.retrieve(response.stripe_user_id)
    # rescue => e
    #   flash[:errors] = [e]
    # end
    user = AdminUser.find(JsonWebToken.decode(params[:state])[:admin_user_id])
    user.update(stripe_connected_account_id: response.stripe_user_id)

    redirect_to '/'
  end

private
  def state_matches?(state_parameter)
    saved_state = Rails.configuration.stripe[:state]
    saved_state == state_parameter
  end
end
