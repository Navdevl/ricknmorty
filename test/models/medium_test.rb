# == Schema Information
#
# Table name: media
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)
#  media_type :integer
#  plot       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MediumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
