class Api::V1::MediaController < Api::V1::ApplicationController 
  
  def index
    @media = Medium.all
  end

  def movies
    @media = Medium.movies
  end

  def series
    @media = Medium.series
  end
end
