Rails.application.routes.draw do
  devise_for :customers,controllers:{
    sessions: 'customers/sessions'
  }
  get 'cart',to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  get 'cart/remove', to: 'cart#remove'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
    get 'about', to: 'pages#about'
    get 'contact', to: 'pages#contact'
resources :categories,only: [:show]
resources :products, only: [:show, :index]
resource :checkout, only: [:show, :create]
post 'confirm_checkout', to: 'checkouts#confirm'
resources :orders, only: [:show]



end
