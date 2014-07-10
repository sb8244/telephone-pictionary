Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  namespace :api, defaults: {format: :json} do
    resources :games, only: [:show, :destroy] do
      member do
        post 'start'
        post 'invite'
        get 'users'
        get 'history'
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
