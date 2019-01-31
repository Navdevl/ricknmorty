class Api::V1::MediaController < Api::V1::ApplicationController 
  skip_before_action :authorize

  def index
    @media = Medium.all
    @detail = params[:detail].present? # This parameter defines whether to show short coded or detailed view.
    @media = @media.includes(:submedia) if @detail
  end

  def movies
    @media = Medium.movie
  end

  def seasons
    @media = Medium.season
    @detail = params[:detail].present? # This parameter defines whether to show short coded or detailed view.
    @media = @media.includes(:submedia) if @detail
  end
end
