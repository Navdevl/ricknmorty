class Api::V1::SessionsController < Api::V1::ApplicationController
  skip_before_action :authorize, only: [:create]

  # POST /sessions
  def create
    user = User.find_by(email: user_params[:email])
    return unauthorized(i18n_content('sign_in.failure')) unless user.present?

    if user.valid_password?(user_params[:password])
      jwt_sign_in(user)
    else
      return unauthorized(i18n_content('sign_in.failure'))
    end
  end

  protected

  def user_params
    params.require(:session).permit(:email, :password)
  end
end
