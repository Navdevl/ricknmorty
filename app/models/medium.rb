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

class Medium < ApplicationRecord

  has_many :submedia

  enum media_types: [:movie, :season]

  def episodes
    if self.season?
      self.submedia
    end
  end
end
