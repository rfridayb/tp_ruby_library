Rails.application.routes.draw do
  root 'books#index'
  
  resources :users, only: [:new,:create,:edit,:update,:show, :destroy]
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  
  post '/books/:id/borrow', to: 'books#borrow'
  post '/books/:id/return', to: 'books#return'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
