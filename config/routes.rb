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

  resources :roles do
    collection do
      get :with_roles
    end
  end

  resources :images, only: :create

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

  resources :sections, only: :index do
    resources :topics, only: [:new, :create, :index]
  end

  resources :topics, only: :show do
    resources :replies, only: [:index, :create, :destroy]
  end

  get "home/index"

  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :posts do
    resources :comments, only: [:index, :create, :destroy]
    member do
      post :publish
    end
    collection do
      get :tag
    end
  end

  get "login" => "sessions#new", as: "login"
  get "logout" => "sessions#destroy", as: "logout"
  get "signup" => "users#new", as: "signup"

  resources :sessions, only: [:new, :create, :destroy]

  root to: "home#index"

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

  resources :statuses do
    member do
      post :like
    end
  end

end
