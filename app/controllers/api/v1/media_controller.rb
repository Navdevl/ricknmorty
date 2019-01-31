class Api::V1::MediaController < Api::V1::ApplicationController 
  skip_before_action :authorize
  before_action :set_detail, except: [:movies]

  def index
    if @detail
      @media = Medium.all.includes(:submedia).latest.order('submedia.sub_id')
    else
      @media = Medium.all.latest
    end
  end

  def movies
    @media = Medium.movie.latest
  end

  def seasons
    if @detail
      @media = Medium.season.includes(:submedia).latest.order('submedia.sub_id')
    else
      @media = Medium.season.latest
    end
  end

  private
  def set_detail
    @detail = params[:detail].present? # This parameter defines whether to show short coded or detailed view.
  end
end
