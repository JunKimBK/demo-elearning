Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"

  resources :users do
    member do
      get :following, :followers
    end
  end

  namespace :admin do
    root "users#index"
    resources :users
    resources :categories do
      resources :words
    end
    resources :words
  end

  resources :categories, only: [:index] do
    resources :lessons, expect: [:destroy]
  end
  resources :words
  resources :relationships, only: [:create, :destroy]
  resources :account_activations, only: [:edit]
end
