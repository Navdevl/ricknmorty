require 'rails_helper'

RSpec.describe 'Media' do
  
  describe 'GET /api/v1/media' do 
    it 'creates a medium' do 
      FactoryGirl.create(:medium)
      get '/api/v1/media'
      json = JSON.parse(response.body)
      expect(json['data'].length).to equal(1)
    end
  end

  describe 'GET /api/v1/media/movies' do 
    it 'creates a medium' do 
      movie =FactoryGirl.create(:medium, media_type: :movie)
      get '/api/v1/media/movies'
      json = JSON.parse(response.body)
      expect(json['data'].length).to equal(1)
    end
  end

  describe 'GET /api/v1/media/seasons' do 
    it 'creates a season' do 
      movie =FactoryGirl.create(:medium, media_type: :season)
      get '/api/v1/media/seasons'
      json = JSON.parse(response.body)
      expect(json['data'].length).to equal(1)
    end
  end
end