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

  # Associations
  has_many :user_media
  has_many :purchases
  has_many :media, through: :user_media, class_name: :medium

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
    user_medium = self.user_media.where(medium_id: medium.id).presence
    if user_media
      return !user_media.expired?    
    end
    return user_media
  end

  def purchase_medium!(medium)
    unless have_active_medium?(medium)
      user_medium = self.user_media.new(medium_id: medium.id)
      if user_media.save
        purchase = self.purchases.new(medium_id: medium.id, user_id: id)
        purchase.save
      end
    end
  end
end
