Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    resources :rooms do
      member do
        post 'join'
      end

      resources :games, controller: "room/games"
    end
  end
end
