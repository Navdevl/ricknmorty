json.user_media do 
  json.array!(@user_media) do |user_medium|
    medium = user_medium.medium
    time_remaining = user_medium.expires_at - Time.now
    json.medium medium.describe
    json.time_remaining time_remaining
  end
end