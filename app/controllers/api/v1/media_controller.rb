class Api::V1::MediaController < Api::V1::ApplicationController 
  skip_before_action :authorize

  def index
    @detail = params[:detail].present? # This parameter defines whether to show short coded or detailed view.
    if @detail
      @media = Medium.all.includes(:submedia).latest
    else
      @media = Medium.all.latest
    end
  end

  def movies
    @media = Medium.movie.latest
  end

  def seasons
    @detail = params[:detail].present? # This parameter defines whether to show short coded or detailed view.
    if @detail
      @media = Medium.season.includes(:submedia).latest
    else
      @media = Medium.season.latest
    end
  end
end
