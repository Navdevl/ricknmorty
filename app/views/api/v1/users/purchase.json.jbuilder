json.user_medium do 
  json.id @user_medium.id
  json.medium @medium.describe
  json.purchased_at @user_medium.purchased_at
  json.expires_at @user_medium.expires_at
end