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

  # Associations
  belongs_to :medium, foreign_key: :parent_medium_id

  # Validations
  validates :sub_id, :name, :plot, presence: true
  validates :sub_id, uniqueness: { scope: :parent_medium_id }

  # Actions
  before_save :refresh_cache
  validate :parent_medium

  protected
  def refresh_cache
    CacheWorker.perform_async(self.class.name, self.id)
  end

  def parent_medium
    return self.errors.add(:medium, "should exist") unless self.medium.present?
    return self.errors.add(:medium, "should be a season") unless self.medium.season?
  end

end
