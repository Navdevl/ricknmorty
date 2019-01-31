# == Schema Information
#
# Table name: purchases
#
#  id         :bigint(8)        not null, primary key
#  medium_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Purchase < ApplicationRecord
  belongs_to :user 
  belongs_to :medium
end
