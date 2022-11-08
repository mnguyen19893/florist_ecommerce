Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  # update address and province
  resources :address, only: [:edit, :update]


end
