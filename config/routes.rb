Rails.application.routes.draw do
  root 'index#index'

  resources :books

  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  namespace :settings do
    get 'notifications', to: 'notifications#index'
    patch 'notifications', to: 'notifications#update'
  end
end
