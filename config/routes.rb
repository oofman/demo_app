Rails.application.routes.draw do
  root 'home#index'

  get "/dashboard" => "home#dashboard" , as: :dashboard

  get "/login" => "sessions#new", as: :login
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy", as: :logout

  resources :champions
  #resources :widgets
  #resources :layouts
  #resources :sites

  #resources :changes, only: [:index, :show]


end
