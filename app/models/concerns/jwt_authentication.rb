module JwtAuthentication
  extend ActiveSupport::Concern

  module ClassMethods
    # Authorizes the token sent in the request header
    # Also refreshes the token if JsonWebToken::REFRESH_JWT_TOKEN are met

    # Returns the user and refreshed token
    def jwt_authorize(headers)
      http_auth_header = headers['Authorization'].split(' ').last if headers['Authorization'].present?

      decoded_auth_token = JsonWebToken.decode(http_auth_header)
      user = User.find_by(id: decoded_auth_token[:user_id])

      if user.present?
        # If password has been changed in another system
        # This logs out the user and forces to enter the new password
        if user.jwt_authenticate?(decoded_auth_token[:jwt_id])
          [nil, nil]
        else
          [user, user.jwt_refresh(decoded_auth_token[:exp])]
        end
      else
        [nil, nil]
      end

      # Try, since user might not be present
      [user, user.try(:jwt_refresh, decoded_auth_token[:exp])]
    end
  end

  # Checks if jwt_id matches during pseudo session
  # Useful when password is changed in other systems
  def jwt_authenticate?(jwt_id)
    !(jwt_id == get_jwt_id)
  end

  # Used to re-hash the hashed version of user password
  # Used to invalidate JWT tokens stored on other systems after password change
  def get_jwt_id
    Digest::SHA1.hexdigest(
      Rails.application.config.jwt_salt_base + encrypted_password
    )
  end

  # Generates JST token
  def jwt_token
    JsonWebToken.encode(user_id: id, jwt_id: get_jwt_id)
  end

  # Refreshes JWT token if JsonWebToken::REFRESH_JWT_TOKEN are met
  def jwt_refresh(exp)
    exp = Time.at(exp.to_i).to_datetime.utc
    sent_at = exp - JsonWebToken::EXPIRE_JWT_TOKEN
    refresh_at = sent_at + JsonWebToken::REFRESH_JWT_TOKEN

    jwt_token if Time.now.utc >= refresh_at
  end
end
