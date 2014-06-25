Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    resources :games, only: [:show, :destroy] do
      member do
        post 'start'
      end
      resources :events, controller: "game/events"
    end

    resources :rooms do
      resources :games, controller: "room/games", only: [:index, :create]

      member do
        post 'join'
      end
    end
  end


  get "*path", to: "application#index"
  root 'application#index'
end
