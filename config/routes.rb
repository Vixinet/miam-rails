Rails.application.routes.draw do
  
  root 'static_pages#home'

  # Static Pages
  # match '/support', to: 'static_pages#support', via: 'get'

  # Handle User & Sessions
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  get    'logout'  => 'sessions#destroy'
  delete 'logout'  => 'sessions#destroy'

  # HAndle Admin space
  match '/admin', to: 'admin#home', via: 'get'  
  namespace :admin do
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

  namespace :api do
    resources :venues, :only => [:index, :show], format: 'json'
  end

  # DEPRECATION GRAVEYARD
  
end
