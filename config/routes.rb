Rails.application.routes.draw do
  resources :users
  get "signup" => "users#new"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  resources :shops
  resources :categories
  get 'welcome/index'

  root 'welcome#index'
end
