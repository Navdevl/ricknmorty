require 'rails_helper'

RSpec.describe 'Users' do
  describe 'POST /api/v1/users/purchase' do 
    it 'allows user to purchase a new media' do 
      media = FactoryGirl.create(:medium)
      user = FactoryGirl.create(:user, password: 'password')

      params = {
        email: user.email,
        password: 'password'
      }
      post '/api/v1/sessions', params: params

      json = JSON.parse(response.body)
      auth_token = json['auth']['token']

      get '/my/path', nil, {'HTTP_ACCEPT' => "application/json"}
    end
  end


  describe 'GET /api/v1/users/media' do 
    it "gets the user's active media" do 
      FactoryGirl.create(:medium)
      get '/api/v1/media'
      json = JSON.parse(response.body)
      expect(json['data'].length).to equal(1)
    end
  end

end