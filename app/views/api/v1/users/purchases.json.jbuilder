json.purchases do 
  json.array!(@purchases) do |purchase|
    json.id purchase.id
    medium = purchase.medium
    json.medium do 
      json.merge! medium.describe
    end
    json.purchased_at purchase.created_at
  end
end
