Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    namespace :v1 do 
      root to: 'application#index'

      devise_for :users, only: [:registrations]

      resources :sessions, only: [:create]

      resources :media, only: [:index] do
        collection do 
          get 'movies'
          get 'seasons'
        end
      end

      resources :users, only: [:index] do 
        collection do 
          post 'purchase'
          get 'media'
          get 'purchases'
        end
      end
    end
  end
end
