# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins

  authenticated :admin do
    root to: 'home#index', as: :authenticated_root
    resources :exchange_rates, only: %i[index new create]
    resources :approvals, only: [:index]
    post '/approvals/:id', to: 'approvals#create', as: 'create_approval'
    resources :exchange_rate_approvals, only: %i[index]
  end

  root to: redirect('/admins/sign_in')

  namespace :api do
    namespace :v1 do
      resources :clients, only: [:show] do
        post 'credit', on: :collection, to: 'clients#add_credit'
      end
      resources :exchange_rates, only: [:index] do
        get 'current', on: :collection
      end
    end
  end
end
