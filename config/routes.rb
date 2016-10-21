Rails.application.routes.draw do

  root 'static_pages#home'

  match '/support',     to: 'static_pages#support', via: 'get'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  get    'logout'  => 'sessions#destroy'
  delete 'logout'  => 'sessions#destroy'

  # DEPRECATION GRAVEYARD
  
end
