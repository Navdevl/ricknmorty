require 'rails_helper'

RSpec.describe 'Users' do
  let!(:user)   { FactoryGirl.create(:user, password: 'password') }
  let!(:medium) { FactoryGirl.create(:medium) }
  let!(:auth_token) { user.jwt_token }

  describe 'POST /api/v1/users/purchase' do 
    it 'allows user to purchase a new media' do 
      params = {medium_id: medium.id}
      headers = {Authorization: auth_token}
      post '/api/v1/users/purchase', params: params, headers: headers
      expect(response).to be_successful
    end

    it 'allows user not to purchase a new media without authorization' do 
      params = {medium_id: medium.id}
      headers = {Authorization: nil}
      post '/api/v1/users/purchase', params: params, headers: headers
      expect(response).not_to be_successful
    end

    it 'will not allow users to purchase the same active medium' do 
      params = {medium_id: medium.id}
      headers = {Authorization: auth_token}
      post '/api/v1/users/purchase', params: params, headers: headers
      post '/api/v1/users/purchase', params: params, headers: headers
      expect(response).not_to be_successful
    end
  end

  describe 'GET /api/v1/users/media' do 
    it "gets the user's active media" do 
      headers = {Authorization: auth_token}
      get '/api/v1/users/media', headers: headers
      expect(response).to be_successful
    end
  end

end