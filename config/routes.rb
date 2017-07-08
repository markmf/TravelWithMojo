Rails.application.routes.draw do

  resources :reviews
  resources :experiences
  resources :photos
  #devise_for :users
  #get 'pages/home'

  root 'pages#home'

  resources :experiences do
    resources :reservations, only: [:create]
  end

 


  get '/search' => 'experiences#index'
   
  
  post 'buy/:/slug', to: 'transactions#create', as: :buy
  get '/pickup/:uuid', to: 'transactions#pickup', as: :pickup
  
  get '/listing', to: 'listing#index', as: :index
  get '/event', to: 'events#index', as: :event



  # New addition for overriding devise
  devise_for :users, 
            :controllers => { :registrations => "my_registrations", sessions: 'sessions', :omniauth_callbacks => 'omniauth_callbacks'}
  
  # devise_for :users, :controllers => { :registrations => "my_registrations", sessions: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
