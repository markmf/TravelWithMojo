Rails.application.routes.draw do



  
  resources :reviews
  resources :experiences
  resources :photos
  resources :payoffs
  resources :hosts
  resources :guests

 
 


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


  resources :conversations do
    resources :messages
  end


  get '/search' => 'experiences#index'
   
  get '/book', to: 'books#create', as: :bookit
  get '/bookpay', to: 'books#index'

  get '/confirm', to: 'confirms#create', as: :confirm

  post 'buy/:/slug', to: 'transactions#create', as: :buy
  get '/pickup/:uuid', to: 'transactions#pickup', as: :pickup
  
  get '/listing',    to: 'listing#index', as: :index
  get '/guestslist', to: 'listing#show',  as: :guestsindex

  get '/event',     to: 'events#index',  as: :event
  get '/history',   to: 'history#index', as: :history

  get '/yourevent/:id(.:format)', to: 'events#show',   as: :yourevent
 # get '/payout', to: 'payout#welcome', as: :payout


resources :revenues, only: [:index]

devise_scope :user do
  post 'verify_phone_number'  => 'my_registrations#verify_phone_number'
  patch 'update_phone_number' => 'my_registrations#update_phone_number'

end




   get '/notification_settings',  to: 'settings#edit'
   post '/notification_settings', to: 'settings#update'
 


  # New addition for overriding devise
  devise_for :users, 
            :controllers => {  :registrations => "my_registrations", sessions: 'sessions', :omniauth_callbacks => 'omniauth_callbacks'}
  
  # :controllers => { :registrations => "my_registrations", sessions: 'sessions', :omniauth_callbacks => 'omniauth_callbacks'}
  # devise_for :users, :controllers => { :registrations => "my_registrations", sessions: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get '/notifications' => 'notifications#index'

  mount ActionCable.server => '/cable'
   
end
