module Tokenizable
  extend ActiveSupport::Concern

private
  def payload(admin_user)
    return nil unless admin_user and admin_user.id
    {
      auth_token: JsonWebToken.encode({ admin_user_id: admin_user.id }),
      admin_user: admin_user.as_json
    }
  end
end
