class JsonWebToken
  # Timeslot in which JWT token is valid until
  # User will be logged out when token expires
  EXPIRE_JWT_TOKEN = 2.weeks

  # Timeslot in which JWT token will be refreshed
  # User will be not be logged out when token expires
  REFRESH_JWT_TOKEN = 24.hours
  # REFRESH_JWT_TOKEN = 1.minute

  class << self
    def encode(payload, exp = EXPIRE_JWT_TOKEN.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.config.jwt_secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.config.jwt_secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue
      {}
    end
  end
end
