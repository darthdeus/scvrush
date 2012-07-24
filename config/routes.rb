Scvrush::Application.routes.draw do

  namespace :admin do
    resources :tournaments
    resources :posts
    resources :coaches
    resources :blog_posts
    resources :users

    match "/staff" => "staff#index"

    root to: "home#index"
  end

  # scope constraints: { protocol: 'https' } do
    get "api/auth"
    get "api/login"
    get "api/check"
  # end

  resources :roles
  resources :pages, only: :show

  # TODO - make this post
  get "practice/join"
  get "practice/quit"
  # TODO - write this as a single line match
  match "/practice" => "practice#index", via: :get

  resources :reply_votes
  resources :raffle_signups
  resources :raffles do
    post :close, on: :member
  end
  resources :avatars

  resources :images, only: :create
  get "dashboard/index", as: 'dashboard'
  get "dashboard/ggbet"

  resources :rounds
  resources :matches
  resources :votes, only: [:create, :destroy]
  resources :tournaments, only: [:new, :create, :index, :show, :edit, :update] do
    member do
      post :seed
      post :unseed
    end
  end
  resources :signups, only: [:create, :destroy, :update]

  resources :sections, only: :index do
    resources :topics, only: [:new, :create, :index]
  end

  resources :topics, only: :show do
    resources :replies, only: [:index, :create, :destroy]
  end

  get "home/index"

  # FIXME - this causes acts_as_taggable to bug any rake tasks,
  # including migrations, as it loads the model and fails on a missing
  # tags table

  get "posts/tag/:id" => "posts#tag", :as => "tag"

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

  root to: "home#index"

  resources :users do
    member do
      post :follow
      delete :unfollow
    end
    resources :statuses do
      member do
        post :upvote
      end
    end
  end
  resources :sessions, only: [:new, :create, :destroy]


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
