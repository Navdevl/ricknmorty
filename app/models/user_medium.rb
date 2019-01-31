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
  belongs_to :user
  belongs_to :medium

  
  DAYS_TO_EXPIRE = 2.days

  before_save :create_additional_timestamps

  def expired?
    expires_at < Time.now
  end

  protected
  def create_additional_timestamps
    self.purchased_at = Time.now
    self.expires_at = Time.now + DAYS_TO_EXPIRE
  end
end
