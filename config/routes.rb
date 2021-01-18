Rails.application.routes.draw do
  resources :users
  get "signup" => "users#new"
  get 'new_addresses', to: 'users#new_address'
  post 'addresses', to: 'users#create_address'
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  resources :shops
  resources :categories
  get 'welcome/index'

  root 'welcome#index'

  get 'top/index'
  resources :list, only: [:new, :create, :edit, :update, :destroy] do
    resources :card, except: :index
  end
end
