require 'rails_helper'

RSpec.describe 'Users' do
  describe 'POST /api/v1/users/purchase' do 
    it 'allows user to purchase a new media' do 
      medium = FactoryGirl.create(:medium)
      user = FactoryGirl.create(:user, password: 'password')
      params = {email: user.email,password: 'password'}
      post '/api/v1/sessions', params: params
      json = JSON.parse(response.body)
      auth_token = json['auth']['token']

      params = {medium_id: medium.id}
      headers = {Authorization: auth_token}
      post '/api/v1/users/purchase', params: params, headers: headers
      expect(response).to be_successful
    end

    it 'allows user not to purchase a new media without authorization' do 
      medium = FactoryGirl.create(:medium)
      params = {medium_id: medium.id}
      headers = {Authorization: nil}
      post '/api/v1/users/purchase', params: params, headers: headers
      expect(response).not_to be_successful
    end
  end


  describe 'GET /api/v1/users/media' do 
    it "gets the user's active media" do 
      get '/api/v1/media', headers: headers
      json = JSON.parse(response.body)
      expect(json['data'].length).to equal(1)
    end
  end

end