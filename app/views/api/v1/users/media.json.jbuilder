json.media do 
  json.array!(@user_media) do |medium|
    json.merge! medium.describe
  end
end