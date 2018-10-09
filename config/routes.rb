Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resource :users
  get '/users', to: 'users#index'
  post '/users', to: 'users#create', as: 'user'
  get '/users/:id', to:'users#show'
  delete '/users/:id', to: 'users#destroy'
  patch '/users/id', to: 'users#update'
  put '/users/:id', to: 'users#update'

  get 'session', to: 'sessions#index'

  mount ActionCable.server => "/cable"
end
