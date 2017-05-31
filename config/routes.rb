Rails.application.routes.draw do
  resources :experiences
  devise_for :users
  #get 'pages/home'

  root 'pages#home'


  post '/buy/:slug', to: 'transactions#create', as: :buy
  get '/pickup/:uuid', to: 'transactions#pickup', as: :pickup
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
