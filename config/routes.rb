Rails.application.routes.draw do
  root 'index#index'

  resources :books do
    post :import, to: 'books/import#create', on: :collection
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  namespace :settings do
    get 'notifications', to: 'notifications#index'
    patch 'notifications', to: 'notifications#update'
  end
end
