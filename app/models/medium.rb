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

  has_many :submedia, foreign_key: :parent_medium_id

  validates :name, :plot, presence: true

  after_save :refresh_cache

  enum media_type: [:movie, :season]

  scope :order_by_episodes, -> {order('submedia.sub_id')}

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
    Rails.cache.delete(Medium.sql_cache_key(media: :all))
    Rails.cache.delete(Medium.sql_cache_key(media: :all, detail: true))

    Rails.cache.delete(Medium.sql_cache_key(media: self.media_type))
    Rails.cache.delete(Medium.sql_cache_key(media: self.media_type, detail: true))

    Rails.cache.write(Medium.sql_cache_key(media: :all), Medium.all.latest)
    Rails.cache.write(Medium.sql_cache_key(media: :all), Medium.all.latest)

    if self.movie?
      Rails.cache.write(Medium.sql_cache_key(media: :movie), Medium.movie.latest)
    else
      Rails.cache.write(Medium.sql_cache_key(media: :season), Medium.season.latest)
      Rails.cache.write(Medium.sql_cache_key(media: :season, detail: true), Medium.season.includes(:submedia).latest.order('submedia.sub_id'))
    end
  end
end
