Rails.application.routes.draw do

  root 'static_pages#home'

  match '/support', to: 'static_pages#support', via: 'get'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  get    'logout'  => 'sessions#destroy'
  delete 'logout'  => 'sessions#destroy'

  match '/admin', to: 'admin#home', via: 'get'  

  namespace :admin do
    #resources :users
    resources :merchants
  end

  # DEPRECATION GRAVEYARD
  
end
