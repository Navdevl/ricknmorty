class Api::V1::MediaController < Api::V1::ApplicationController 
  skip_before_action :authorize
  before_action :set_detail, except: [:movies]

  def index
    media = Medium.cached_all_media(detail: @detail)
    render json: media
  end

  def movies
    media = Medium.cached_movies
    render json: media
  end

  def seasons
    media = Medium.cached_seasons(detail: @detail)
    render json: media
  end

  private
  def set_detail
    @detail = params[:detail].present? # This parameter defines whether to show short coded or detailed view.
  end
end
