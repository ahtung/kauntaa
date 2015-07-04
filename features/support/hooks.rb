if ENV['RAILS_ENV'] == 'production'
  Capybara.app_host = 'http://www.kauntaa.com'
  Capybara.run_server = false
elsif ENV['RAILS_ENV'] == 'staging'
  Capybara.app_host = 'http://staging.kauntaa.com'
  Capybara.run_server = false
else
  Capybara.run_server = true
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.javascript_driver = :selenium
