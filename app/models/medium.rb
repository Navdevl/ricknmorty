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
  has_many :submedia, foreign_key: :parent_medium_id, dependent: :destroy

  # Validations
  validates :name, :plot, presence: true

  # Actions
  after_save :refresh_cache
  after_destroy :refresh_cache

  # Scopes
  scope :order_by_episodes, -> {order('submedia.sub_id')}
  
  # Enums
  enum media_type: [:movie, :season]

  def episodes
    if self.season?
      self.submedia
    end
  end

  def self.cache_key(media_type: :all, detail: false)
    return "#{media_type.to_s}_media_detail" if detail
    "#{media_type.to_s}_media"
  end

  def self.cached_all_media(detail: false)
    media = Rails.cache.fetch(Medium.cache_key(media_type: :all, detail: detail)) do
      if detail
        Medium.all.includes(:submedia).latest.order_by_episodes
      else
        Medium.all
      end
    end
  end

  def self.cached_movies
    movies = Rails.cache.fetch(Medium.cache_key(media_type: :movie, detail: @detail)) do
      Medium.movie.latest
    end
  end

  def self.cached_seasons(detail)
    media = Rails.cache.fetch(Medium.cache_key(media_type: :season, detail: detail)) do
      if detail
        Medium.season.includes(:submedia).latest.order_by_episodes
      else
        Medium.season
      end
    end
  end

  protected
  def refresh_cache
    CacheWorker.perform_async(self.class.name, self.id)
  end
end
