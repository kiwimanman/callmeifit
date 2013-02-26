Callmeifit::Application.routes.draw do
  root :to => 'application#home'
  resources :launches
  resources :users
  resources :phones, do
    collection do
      match 'with_code/:code' => 'phones#with_code', :as => 'with_code'
    end
    member do
      get  'verify'
      post 'confirm'
    end
  end
  resources :ski_resorts, :path => 'snows' do
    member do
      match 'notify'
      get 'test'
    end
  end
  resources :about, :only => :index

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/logout', to: 'sessions#logout', as: 'logout'

  resources :emails, only: :create
end
