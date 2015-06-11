Callmeifit::Application.routes.draw do
  root to: 'application#home'
  resources :launches
  resource :user do
    collection do
      get 'all'
    end
  end
  resources :phones do
    collection do
      post 'with_code/:code' => 'phones#with_code', :as => 'with_code'
    end
    member do
      get 'verify'
      post 'confirm'
    end
  end
  resources :ski_resorts, path: 'snows' do
    member do
      post 'notify'
      get 'test'
    end
  end
  resources :about, only: :index

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/logout', to: 'sessions#logout', as: 'logout'

  resources :emails, only: :create
end
