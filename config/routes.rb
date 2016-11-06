Rails.application.routes.draw do
  
  resources :opt_ins, :only => [:create]
  resources :cities, :only => [:create]

  match '/cities/:id/vote', to: 'cities#vote', via: 'put', as: 'vote_city'

  root 'static_pages#home'

  # Static Pages
  # match '/support', to: 'static_pages#support', via: 'get'

  # Handle User & Sessions
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  get    'logout'  => 'sessions#destroy'
  delete 'logout'  => 'sessions#destroy'

  # Handle Admin space
  match '/admin', to: 'admin#home', via: 'get'  

  namespace :admin do
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
