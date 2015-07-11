Rails.application.routes.draw do
  mount_roboto
  mount API => '/'

  get 'pages/about'

  constraints(format: 'xml') do
    get '/sitemap', to: redirect('https://s3.eu-central-1.amazonaws.com/kauntaa/sitemaps/sitemap.xml.gz')
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  authenticated :user do
    root 'counters#index', as: :user_root
  end

  get 'counter/new', to: 'counters#new_counter'

  root 'pages#welcome', as: :guest_root

  resources :users do
    resources :counters do
      member do
        get 'increment'
        get 'decrement'
      end
    end
  end
end
