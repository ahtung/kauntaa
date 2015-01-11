Rails.application.routes.draw do
  get 'pages/about'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'pages#home'
end
