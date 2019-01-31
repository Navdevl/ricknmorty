class Api::V1::UsersController < Api::V1::ApplicationController 
  before_action :set_medium, only: [:purchase]

  def index
  end

  def media
    @user_media = @current_user.media
  end

  def purchase
    @user_medium = @current_user.purchase_medium!(@medium)
    if @current_user.errors.any?
      forbidden(@current_user.errors.full_messages.first) and return
    end
  end

  def purchases
    @current_user.purchases
  end

  private
  def set_medium
    @medium = Medium.find_by(id: params[:medium_id])
    page_not_found and return unless @medium.present?
  end
end
