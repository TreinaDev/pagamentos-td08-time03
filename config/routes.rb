Rails.application.routes.draw do
  devise_for :admins
  root 'home#index'

  resources :exchange_rates, only: [:index, :new, :create]
end
