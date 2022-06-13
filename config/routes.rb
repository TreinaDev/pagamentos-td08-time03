Rails.application.routes.draw do
  devise_for :admins

  authenticated :admin do
    root to: 'home#index', as: :authenticated_root
  end
  root to: redirect('/admins/sign_in')
  resources :approvals, only: [:index] do
    patch 'new', on: :member
  end

  resources :exchange_rates, only: [:index, :new, :create]
end
