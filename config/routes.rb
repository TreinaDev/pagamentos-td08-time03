Rails.application.routes.draw do
  devise_for :admins

  authenticated :admin do
    root to: 'home#index', as: :authenticated_root
    resources :exchange_rates, only: [:index, :new, :create]
    resources :approvals, only: [:index]
    post '/approvals/:id', to: 'approvals#create', as: 'create_approval'
  end

  root to: redirect('/admins/sign_in')


end
