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

require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
