json.user_media do 
  json.array!(@user_media) do |user_medium|
    json.id user_medium.id
    medium = user_medium.medium
    json.medium medium.describe
    json.time_remaining user_medium.time_remaining
  end
end