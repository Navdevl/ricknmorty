# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  name                   :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable
  HAS_ACTIVE_MEDIUM_ERROR = "You have already purchased this media" # This can be moved to en.yml too

  # Associations
  has_many :user_media, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :media, through: :user_media, source: :medium

  # Validations
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

  def profile
    {
      id: self.id,
      name: self.name,
      email: self.email
    }
  end

  # Checks whether the user holds the current medium in active state
  def have_active_medium?(medium)
    user_medium = self.user_media.find_by(medium_id: medium.id).presence
    if user_medium
      return !user_medium.expired?    
    end
    return user_medium
  end

  # Function call to purchase a medium
  def purchase_medium!(medium)
    if have_active_medium?(medium)
      self.errors.add(:base, HAS_ACTIVE_MEDIUM_ERROR)
    else
      user_medium = self.user_media.new(medium_id: medium.id)
      if user_medium.save
        purchase = self.purchases.new(medium_id: medium.id, user_id: id)
        purchase.save
      end
      return user_medium
    end
  end

  # Authorizes the token sent in the request header
  # Also refreshes the token if JsonWebToken::REFRESH_JWT_TOKEN are met

  # Returns the user and refreshed token
  def self.jwt_authorize(headers)
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

  # Fetches or Caches the user's media
  def cached_user_media
    Rails.cache.fetch(UserMedium.cache_key(self)) do
      self.user_media.active.includes(:medium)
    end
  end

  # Fetches or Caches the user's purchases
  def cached_purchases
    Rails.cache.fetch(Purchase.cache_key(self)) do
      self.purchases.includes(:user, :medium)
    end
  end
end
