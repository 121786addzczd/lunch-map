Rails.application.routes.draw do
  resources :users
  get "signup" => "users#new"
  resources :shops
  resources :categories
  get 'welcome/index'

  root 'welcome#index'
end
