class Api::V1::UsersController < Api::V1::ApplicationController 
  before_action :set_medium, only: [:purchase]

  def index
    render json: @current_user
  end

  def media
    user_media = @current_user.cached_user_media
    render json: user_media, include: ['medium', 'user']
  end

  def purchase
    @user_medium = @current_user.purchase_medium!(@medium)
    if @current_user.errors.any?
      forbidden(@current_user.errors.full_messages.first) and return
    end
    render json: @user_medium, include: ['medium', 'user']
  end

  def purchases
    @purchases = Rails.cache.fetch("purchases_#{@current_user.id}") do
      @current_user.purchases
    end

    render json: @purchases, include: ['medium', 'user']
  end

  private
  def set_medium
    @medium = Medium.find_by(id: params[:medium_id])
    page_not_found and return unless @medium.present?
  end
end
