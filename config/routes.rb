Rails.application.routes.draw do
  # Robots
  mount_roboto

  # API
  mount API => "/"

  # Sitemap
  constraints(format: "xml") do
    get "/sitemap", to: redirect("https://s3.eu-central-1.amazonaws.com/kauntaa/sitemaps/sitemap.xml.gz")
  end

  # Users
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  authenticated :user do
    # User root
    root "counters#index", as: :user_root
  end

  # Counters
  resources :counters, only: [:edit, :new, :show] do
    collection do
      get 'add'
    end
  end
end
