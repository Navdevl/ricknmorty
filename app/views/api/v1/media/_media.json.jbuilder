json.media do 
  json.array!(media) do |medium|
    json.merge! medium.describe
    json.media_type medium.media_type
    if medium.season? and detail
      episodes = medium.episodes
      json.episodes do 
        json.array!(episodes) do |episode|
          json.merge! episode.describe
          json.sub_id episode.sub_id
        end
      end
    end
  end
end