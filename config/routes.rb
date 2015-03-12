Rails.application.routes.draw do
  get "welcome/index"
  root to: "welcome#index"
  resources :users
  resources :dogs
  resources :matches
  resources :observations
  get "auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
