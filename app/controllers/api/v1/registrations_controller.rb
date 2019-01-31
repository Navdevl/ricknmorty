class Api::V1::RegistrationsController < Api::V1::ApplicationController
  skip_before_action :authorize, only: [:create]

  # POST /sessions
  def create
    user = User.find_by(email: user_params[:email])
    return unauthorized(i18n_content('sign_up.already_registered')) if user.present?

    user = User.new(email: user_params[:email], 
                    name: user_params[:name],
                    password: user_params[:password],
                    password_confirmation: user_params[:password_confirmation])
    if user.save
      jwt_sign_in(user)
    else
      return unauthorized(i18n_content('sign_up.failure'))
    end
  end

  protected

  def user_params
    params.permit(:email, :name, :password, :password_confirmation)
  end
end
