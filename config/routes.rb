Rails.application.routes.draw do



  #resources :users
  resources :reviews
  resources :experiences
  resources :photos
  resources :payoffs
  #devise_for :users
  #get 'pages/home'

  root 'pages#home'

 #resources :experiences, :has_many => [:reviews]

  #resources :experiences do
   #  resources :reservations, only: [:create]
  #end

 resources :experiences do
    resources :reviews, only: [:create, :new, :destroy]
  end


  get '/search' => 'experiences#index'
   
  
  post 'buy/:/slug', to: 'transactions#create', as: :buy
  get '/pickup/:uuid', to: 'transactions#pickup', as: :pickup
  
  get '/listing', to: 'listing#index', as: :index
  get '/event', to: 'events#index', as: :event
 # get '/payout', to: 'payout#welcome', as: :payout


  #post 'users/verify_phone_number' =>  'sessions#verify_phone_number'
  #patch 'users/update_phone_number' => 'sessions#update_phone_number'

 
   post '/verify_phone_number'  =>  'my_registrations#verify_phone_number'
   patch '/update_phone_number' => 'my_registrations#update_phone_number'
   

   get '/notification_settings',  to: 'settings#edit'
   post '/notification_settings', to: 'settings#update'
 


  # New addition for overriding devise
  devise_for :users, 
            :controllers => { :registrations => "my_registrations", sessions: 'sessions', :omniauth_callbacks => 'omniauth_callbacks'}
  
  # :controllers => { :registrations => "my_registrations", sessions: 'sessions', :omniauth_callbacks => 'omniauth_callbacks'}
  # devise_for :users, :controllers => { :registrations => "my_registrations", sessions: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
