Rails.application.routes.draw do
  
  resources :orders
  resources :addresses, :except => [:show]
  resources :payments, :only => [:index, :new, :create]
  resources :venues, :only => [:show]
  # resources :users, :only => [:edit, :create, :update]

  root 'venues#index'

  # Static Pages
  match '/support', to: 'static_pages#support', :via => :get

  # get    '/account'   => 'sessions#show'
  # get    '/credits'   => 'sessions#credits'

  # Handle User & Sessions
  # get    'signup'  => 'users#new'
  # post   'signup'  => 'users#create'
  # post   'edit'    => 'users#edit'
  # get    'login'   => 'sessions#new'
  # post   'login'   => 'sessions#create'
  # get    'logout'  => 'sessions#destroy'
  # delete 'logout'  => 'sessions#destroy'

  
  match 'account', to: 'sessions#show', :via => :get
  match 'account/edit', to: 'users#edit', :via => :get
  match 'account/edit', to: 'users#update', :via => [:post, :patch]
  match 'credits', to: 'sessions#credits', :via => :get
  match 'signup', to: 'users#new', :via => :get
  match 'signup', to: 'users#create', :via => :post
  match 'login', to: 'sessions#new', :via => :get
  match 'login', to: 'sessions#create', :via => :post
  match 'logout', to: 'sessions#destroy', :via => [:get, :delete]
  match 'auth/:provider/callback', to: 'sessions#create_from_omniauth', :via => [:get, :post]
  match 'auth/failure', to: redirect('/'), :via => [:get, :post]

  # Handle Admin space
  match '/admin', to: 'admin#home', :via => 'get'  

  namespace :admin do
    resources :users
    resources :cities, :except => :show
    resources :merchants
    resources :venues do
      resources :product_groups, :except => :index, shallow: true do
        resources :products, :except => :index, shallow: true do
          resources :product_variations, :except => [:index, :show], shallow: true do
            resources :variation_options, :except => [:index, :show], shallow: true
          end
        end
      end
    end
  end

  # Release Candidate 2

  # namespace :api do
  #   resources :venues, :only => [:index, :show], format: 'json'
  # end

  # DEPRECATION GRAVEYARD

  
end
