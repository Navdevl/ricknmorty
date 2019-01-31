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

  def expired?
    expires_at < Time.now
  end
end
