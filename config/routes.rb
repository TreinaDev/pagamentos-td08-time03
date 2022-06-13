Rails.application.routes.draw do
  devise_for :admins

  authenticated :admin do
    root to: 'home#index', as: :authenticated_root
  end
  root to: redirect('/admins/sign_in')

  resources :exchange_rates, only: [:index, :new, :create]

  namespace :api do
    namespace :v1 do
      resources :clients do
        post 'credit', on: :member
      end
    end
  end
end
