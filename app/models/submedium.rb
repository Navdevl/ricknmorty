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

class Submedium < ApplicationRecord

  belongs_to :medium, foreign_key: :parent_medium_id

  validates :sub_id, uniqueness: { scope: :parent_medium_id }

end
