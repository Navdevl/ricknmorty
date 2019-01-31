# == Schema Information
#
# Table name: submedia
#
#  id               :bigint(8)        not null, primary key
#  name             :string(255)
#  plot             :string(255)
#  sub_id           :integer
#  parent_medium_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class SubmediumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
