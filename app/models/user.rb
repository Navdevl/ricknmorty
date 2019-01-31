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
  has_many :user_media
  has_many :purchases
  has_many :media, through: :user_media, source: :medium

  # Validations
  validates :name, :email, presence: true
  validates :email, uniqueness: true


  include JwtAuthentication

  def profile
    {
      id: self.id,
      name: self.name,
      email: self.email
    }
  end

  def have_active_medium?(medium)
    user_medium = self.user_media.find_by(medium_id: medium.id).presence
    if user_medium
      return !user_medium.expired?    
    end
    return user_medium
  end

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
end
