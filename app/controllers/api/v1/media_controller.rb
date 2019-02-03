class Api::V1::MediaController < Api::V1::ApplicationController 
  skip_before_action :authorize
  before_action :set_detail, except: [:movies]

  def index
    if @detail
      @media = Rails.cache.fetch(Medium.sql_cache_key(media_type: :all, detail: @detail)) do
        Medium.all.includes(:submedia).latest.order_by_episodes
      end
    else
      @media = Rails.cache.fetch(Medium.sql_cache_key(media_type: :all, detail: @detail)) do
        Medium.all.latest
      end
    end
    
    render json: @media

  end

  def movies
    @media = Rails.cache.fetch(Medium.sql_cache_key(media_type: :movie, detail: @detail)) do
      Medium.movie.latest
    end
  end

  def seasons
    if @detail
      @media = Rails.cache.fetch(Medium.sql_cache_key(media_type: :season, detail: @detail)) do
        Medium.season.includes(:submedia).latest.order_by_episodes
      end
    else
      @media = Rails.cache.fetch(Medium.sql_cache_key(media_type: :season, detail: @detail)) do
        Medium.season.latest
      end
    end
  end

  private
  def set_detail
    @detail = params[:detail].present? # This parameter defines whether to show short coded or detailed view.
  end
end
