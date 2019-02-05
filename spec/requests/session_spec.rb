require 'rails_helper'

RSpec.describe "Sessions" do
  describe 'POST /api/v1/sessions' do 
    it "log in user" do
      user = FactoryGirl.create(:user, password: 'password')
      params = {
        email: user.email,
        password: 'password'
      }
      post '/api/v1/sessions', params: params
      expect(response).to be_success
    end

    it "should not allow to login" do 
      user = FactoryGirl.create(:user, password: 'password')
      params = {
        email: user.email,
        password: 'wrong_password'
      }
      post '/api/v1/sessions', params: params
      expect(response).not_to be_success
    end

    it "should return auth token" do 
      user = FactoryGirl.create(:user, password: 'password')
      params = {
        email: user.email,
        password: 'password'
      }
      post '/api/v1/sessions', params: params
      json = JSON.parse(response.body)
      expect(json['auth']['token']).to be_present
    end
  end
end