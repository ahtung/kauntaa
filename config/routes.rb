Rails.application.routes.draw do
  get 'pages/about'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  authenticated :user do
    root 'pages#home', as: :user_root
  end

  root 'pages#about', as: :guest_root

  resources :users do
    resources :counters do
      member do
        get 'increment'
        get 'decrement'
      end
    end
  end
  root 'pages#home'

end
