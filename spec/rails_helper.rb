#
ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'helpers'
require 'capybara/poltergeist'
require 'pundit/rspec'
Dir["./spec/support/**/*.rb"].sort.each { |f| require f}
Capybara.javascript_driver = :poltergeist

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.order = 'random'

  config.alias_it_should_behave_like_to :it_behaves_like, 'can'
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.include ActionView::Helpers::DateHelper
  config.include FactoryGirl::Syntax::Methods
  config.include Helpers

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
