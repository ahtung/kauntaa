source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby '2.1.2'

gem 'rails', '4.2.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'foreman'
gem 'slim-rails'
gem 'foundation-rails'
gem 'devise'
gem 'rack-google-analytics'
gem 'omniauth-google-oauth2'
gem 'newrelic_rpm'
gem 'rails-assets-FlipClock'
gem 'rails-assets-font-awesome'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'rubocop', require: false
  gem 'brakeman', require: false
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rspec-rails'
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  # gem 'selenium-webdriver'
  gem 'poltergeist'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
end