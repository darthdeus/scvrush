Scvrush::Application.routes.draw do

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

  get "/" => "home#index", as: "home"
  get "/dashboard" => "dashboard#index", as: "dashboard"

  resources :users
  resources :sessions
  resources :posts
  resources :coaches
  resources :tournaments do
    member do
      get :signups
      get :ca
      get :matches

      put :start
      put :randomize
      put :seed

      delete :destroy_seed
    end
  end

  get "login" => "sessions#new", as: "login"
  delete "logout" => "sessions#destroy", as: "logout"

  root to: "home#index"
end
