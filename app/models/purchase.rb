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
  # Associations
  belongs_to :user, dependent: :nullify 
  belongs_to :medium, dependent: :nullify

  def self.cache_key(user=nil)
    return "" unless user.present?
    purchases = Purchase.where(user_id: user.id)
    "purchase_#{user.id}_#{purchases.maximum(:updated_at)}"
  end
end
