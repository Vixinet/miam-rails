Rails.application.routes.draw do
  
  resources :addresses, :except => [:show]
  resources :payments, :only => [:index, :new, :create]
  resources :venues, :only => [:show]

  root 'venues#index'

  # Static Pages
  match '/support', to: 'static_pages#support', via: 'get'

  get    '/account'   => 'sessions#show'
  get    '/credits'   => 'sessions#credits'

  # Handle User & Sessions
  get    'signup'  => 'users#new'
  post   'signup'  => 'users#create'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  get    'logout'  => 'sessions#destroy'
  delete 'logout'  => 'sessions#destroy'
  

  # Handle Admin space
  match '/admin', to: 'admin#home', via: 'get'  

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
