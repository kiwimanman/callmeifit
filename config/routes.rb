Callmeifit::Application.routes.draw do
  root :to => 'launches#root'
  resources :launches
  resources :users
  resources :ski_resorts, :path => 'snows'

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/logout', to: 'sessions#logout', as: 'logout'

end
