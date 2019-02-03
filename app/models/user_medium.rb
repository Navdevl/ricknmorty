# == Schema Information
#
# Table name: user_media
#
#  id           :bigint(8)        not null, primary key
#  medium_id    :integer
#  user_id      :integer
#  purchased_at :datetime
#  expires_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class UserMedium < ApplicationRecord
  DAYS_TO_EXPIRE = 2.days
  
  # Associations
  belongs_to :user
  belongs_to :medium

  # Validations

  # Actions
  before_create :create_additional_timestamps
  after_save :refresh_cache
  after_destroy :refresh_cache 

  # Scopes 
  scope :active, -> {where("expires_at > ?", Time.now)}

  def expired?
    time_remaining < 0
  end

  def expires_in
    self.expires_at - Time.now
  end

  def self.cache_key(user=nil)
    return "" unless user.present?
    user_media = UserMedium.where(user_id: user.id).active
    "user_media_#{user.id}_#{user_media.minimum(:expires_at)}"
  end

  protected
  def refresh_cache
    CacheWorker.perform_async(self.class.name, self.user.id)
  end

  def create_additional_timestamps
    self.purchased_at = Time.now
    self.expires_at = Time.now + DAYS_TO_EXPIRE
  end
end
