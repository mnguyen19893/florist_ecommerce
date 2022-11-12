Rails.application.routes.draw do
  resources :product, only: [:index, :show] do
    collection do
      get 'filter'
    end
  end

  resources :category, only: [:index, :show]

  # admin_users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # devise
  devise_for :users
  
  # root
  root to: 'product#index'

  # update address and province
  resources :address, only: %i[edit update]

  get '/about', to: 'about#index', as: 'about'
  get '/contact', to: 'about#contact', as: 'contact'
end
