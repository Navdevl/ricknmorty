Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, only: []

  namespace :api, defaults: {format: :json} do
    namespace :v1 do 

      root to: 'application#index'

    end
  end
end
