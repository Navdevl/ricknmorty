class Api::V1::ApplicationController < ActionController::API
  before_action :authorize, except: [:index]

  def index
    render json: {success: true}
  end

  private

  def authorize
    user, new_token = User.jwt_authorize(request.headers)
    if new_token.present?
      response.headers['Authorization'] = new_token
    end

    unauthorized and return unless user.present?
    @current_user = user
  end

  def success_message(message)
    render json: {
      message: message,
      status: 200
    }, status: 200
  end

  def page_not_found(message=I18n.t('api.v1.application.page_not_found'))
    render json: {
      message: message,
      status: 404
    }, status: 404
  end

  def forbidden(message=I18n.t('api.v1.application.forbidden'))
    render json: {
      message: message,
      status: 403
    }, status: 403
  end

  def unauthorized(message=I18n.t('api.v1.application.authorize.invalid'))
    render json: {
      message: message,
      status: 401
    }, status: 401
  end

  def unconfirmed(message=I18n.t('api.v1.application.authorize.unconfirmed'))
    render json: {
      message: message,
      status: 400
    }, status: 400
  end

  def i18n_content(path, params={})
    I18n.t("api.v1.#{controller_name}.#{path}", params)
  end

  def jwt_sign_in(user)
    render json: {
      message: i18n_content('sign_in.success'),
      user: user.profile,
      auth: {
        token: user.jwt_token
      }
    }
  end
end
