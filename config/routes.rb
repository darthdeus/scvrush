Scvrush::Application.routes.draw do

  get "signups/index"

  namespace :admin do
    resources :tournaments do
      resources :signups
    end
    resources :posts
    resources :coaches
    resources :users

    match "/staff" => "staff#index"

    root to: "home#index"
  end

  get "api/auth"
  get "api/login"
  get "api/check"
  get "api/user_data"
  get "api/streams"

  namespace :api, format: :json do

    resources :notifications
    resources :achievements

    resources :rounds
    resources :matches
    resources :votes, only: [:create, :destroy]

    resources :brackets
    resources :tournaments do
      member do
        post :start
        post :seed
        post :unseed
        get :emails
        post :randomize
      end
    end
    resources :signups

    resources :posts
    resources :statuses
    resources :coaches

    get "login" => "sessions#new", as: "login"
    delete "logout" => "sessions#destroy", as: "logout"
    get "signup" => "users#new", as: "signup"

    resources :sessions, only: [:new, :create, :destroy]

    resources :users do
      collection do
        get :validate
      end

      member do
        post    :follow
        delete  :unfollow
        get     :info
        get     :friends
      end
    end
  end

  match "*path" => "home#index"
  root to: "home#index"
end
