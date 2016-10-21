Rails.application.routes.draw do

  root 'static_pages#home'

  match '/support',     to: 'static_pages#support', via: 'get'


  # DEPRECATION GRAVEYARD
end
