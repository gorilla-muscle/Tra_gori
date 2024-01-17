Rails.application.routes.draw do
  root "static_pages#top"
  get "/term", to: "static_pages#term"
  get "/privacy", to: "static_pages#privacy"
  get "/contact", to: "static_pages#contact"

  resources :users, only: %i[new create] do
    resources :albums, only: %i[index show]
  end
  resource :users_profiles, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]

  get '/login', to:  'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy', as: :logout

  get "oauth/callback", to:  "oauths#callback"
  post "oauth/callback", to:  "oauths#callback"
  get "oauth/:provider", to:  "oauths#oauth", as: :auth_at_provider

  resources :training_records, only: %i[index create show]
  resources :training_reports, only: %i[index show]
  resources :gachas, only: %i[new create] do
    member do
      get :result
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
