require 'jwt'

class JsonWebToken
  def self.encode(payload)
    JWT.encode(
      payload,
      Equisettle::Application.credentials.secret_key_base
    )
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(
      JWT.decode(
        token,
        Equisettle::Application.credentials.secret_key_base
      )[0]
    )
  rescue
    nil
  end
end
