Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  namespace :api, defaults: {format: :json} do
    resources :games do
      member do
        post 'start'
        post 'invite'
        get 'users'
        get 'history'
      end
      resources :events, controller: "game/events"
    end
  end

  get "*path", to: "application#index"
  root 'application#index'
end
