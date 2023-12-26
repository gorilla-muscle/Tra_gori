Rails.application.routes.draw do
  root "static_pages#top"

  resources :users, only: %i[new create]
  get '/login', to:  'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy', as: :logout

  get "oauth/callback", to:  "oauths#callback"
  post "oauth/callback", to:  "oauths#callback"
  get "oauth/:provider", to:  "oauths#oauth", as: :auth_at_provider

  resources :training_records, only: %i[index create show]
end
