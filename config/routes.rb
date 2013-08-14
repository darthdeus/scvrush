Scvrush::Application.routes.draw do

  namespace :api do
    resources :users
  end

  namespace :admin do
    get "/" => "home#index"
    resources :tournaments do
      resources :signups
    end
    resources :posts
    resources :coaches
    resources :users

    match "/staff" => "staff#index", via: :get
  end

  get "/" => "home#index", as: "home"
  get "/staff" => "home#staff", as: "staff"
  get "/contact" => "home#contact", as: "contact"
  get "/meet_scvrush" => "home#meet_scvrush", as: "meet_scvrush"

  get "/dashboard" => "dashboard#index", as: "dashboard"

  resources :activations
  resources :coaches
  resources :matches
  resources :posts
  resources :statuses
  resources :sessions

  resources :tournaments do
    resources :signups do
      collection { post :add_user }
      member { put :check_in_user }
    end
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

  resources :users do
    member do
      get :activation
      put :activate
      put :follow
      delete :unfollow
    end
  end


  get "login" => "sessions#new", as: "login"
  delete "logout" => "sessions#destroy", as: "logout"

  root to: "home#index"
end
