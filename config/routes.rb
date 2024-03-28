Rails.application.routes.draw do
  get 'cart',to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  get 'cart/remove', to: 'cart#remove'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
    get 'about', to: 'pages#about'
    get 'contact', to: 'pages#contact'
resources :categories,only: [:show]
# resources :products,only: [:show]
# resources :products, only: [:index]
resources :products, only: [:show, :index]
resource :checkout, only: [:show, :create]
end
