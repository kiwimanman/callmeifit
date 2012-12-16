Callmeifit::Application.routes.draw do
  root :to => 'launches#root'
  resources :launches
  resources :users
  resources :phones, do
    collection do
      match 'with_code'
    end
    member do
      get  'verify'
      post 'confirm'
    end
  end
  resources :ski_resorts, :path => 'snows'

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/logout', to: 'sessions#logout', as: 'logout'

end
