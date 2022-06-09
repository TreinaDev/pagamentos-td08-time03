Rails.application.routes.draw do
  root 'home#index'

  resources :exchange_rates, only: [:index, :new, :create]
end
