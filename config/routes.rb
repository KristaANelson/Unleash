Rails.application.routes.draw do
  root to: "welcome#index"
  resources :users, only: [:create]
  resources :dogs
  resources :matches, only: [:index]
  resources :search_preferences, only: [:new, :create, :edit, :update]
  resources :observations, only: [:index, :new, :create]
  get "auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/logout", to: "sessions#destroy"
  get "/introduction", to:"welcome#show"
end
