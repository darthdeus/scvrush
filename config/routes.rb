Scvrush::Application.routes.draw do

  namespace :admin do
    resources :tournaments do
      resources :signups
    end
    resources :posts
    resources :coaches
    resources :users

    match "/staff" => "staff#index", via: :get
  end

  get "/" => "home#index", as: "home"
  get "/contact" => "home#contact"
  get "/meet_scvrush" => "home#meet_scvrush"
  get "/dashboard" => "dashboard#index", as: "dashboard"

  resources :statuses
  resources :users do
    member do
      get :activation
      put :activate
    end
  end

  resources :activations

  resources :sessions
  resources :posts
  resources :coaches
  resources :tournaments do
    member do
      get :signups
      get :checked_trial_players
      get :matches

      put :start
      put :randomize
      put :seed

      delete :destroy_seed
    end
  end

  resources :matches


  get "login" => "sessions#new", as: "login"
  delete "logout" => "sessions#destroy", as: "logout"

  root to: "home#index"
end
