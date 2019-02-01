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

  # Associations
  has_many :submedia, foreign_key: :parent_medium_id

  # Validations
  validates :name, :plot, presence: true

  # Actions
  after_save :refresh_cache

  # Scopes
  scope :order_by_episodes, -> {order('submedia.sub_id')}
  
  # Enums
  enum media_type: [:movie, :season]

  def self.fragment_cache_key(media: Medium.all, media_type: :all)
    "#{media_type.to_s}_media_#{media.maximum(:updated_at)}"
  end

  def self.sql_cache_key(media_type: :all, detail: false)
    return "#{media_type.to_s}_media_detail" if detail
    "#{media_type.to_s}_media"
  end

  def episodes
    if self.season?
      self.submedia
    end
  end

  protected
  def refresh_cache
    CacheWorker.perform_async(self.class.name, self.id)
  end
end
