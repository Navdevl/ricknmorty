class CacheWorker
  # This worker initates reset cache and creation of new cache when an action is done on a record
  include Sidekiq::Worker
  sidekiq_options retry: false # Either try or fail. So, it will Cache during the user-hit


  def perform(classname, info)
    if classname == "UserMedium"
      cache_user_medium(info)
    elsif classname == "Medium"
      cache_medium(info)
    elsif classname == "Submedium"
      cache_submedium(info)
    end
  end

  def delete_cache(cache_keys)
    cache_keys.each do |cache_key|
      Rails.cache.delete(cache_key)
    end
  end

  def cache_user_medium(user_id)
    user = User.find_by(id: user_id)
    if user.present?
      Rails.cache.delete(UserMedium.cache_key(user))
      Rails.cache.write(UserMedium.cache_key(user), user.user_media.active.includes(:medium))
    end
  end

  def cache_medium(medium_id)
    delete_cache([Medium.cache_key(media_type: :all), 
                  Medium.cache_key(media_type: :all, detail: true)]
    Rails.cache.write(Medium.cache_key(media_type: :all), Medium.all.latest)
    Rails.cache.write(Medium.cache_key(media_type: :all), Medium.all.latest)
    medium = Medium.find_by(id: medium_id)
    return unless medium.present?

    delete_cache([Medium.cache_key(media_type: :all), 
                  Medium.cache_key(media_type: :all, detail: true),
                  Medium.cache_key(media_type: medium.media_type),
                  Medium.cache_key(media_type: medium.media_type, detail: true)])

    if medium.movie?
      Rails.cache.write(Medium.cache_key(media_type: :movie), Medium.movie.latest)
    else
      Rails.cache.write(Medium.cache_key(media_type: :season), Medium.season.latest)
      Rails.cache.write(Medium.cache_key(media_type: :season, detail: true), Medium.season.includes(:submedia).latest.order_by_episodes)
    end
  end

  def cache_submedium(submedium_id)
    submedium = Submedium.find_by(id: submedium_id)
    return unless submedium.present?
    cache_medium(submedium.parent_medium_id)
  end
end
