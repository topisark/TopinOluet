# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'webmock/rspec'
require 'coveralls'
Coveralls.wear!
I18n.enforce_available_locales = false

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL
  config.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }
end

def sign_in(credentials)
  visit breweries_path
  fill_in('username', with: credentials[:username])
  fill_in('password', with: credentials[:password])
  click_button('Sign in')
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score: score, beer: beer, user: user)
  return beer
end

def create_beer_with_rating_for_brewery(brewery, score)
  beer = FactoryGirl.create(:beer, brewery: brewery)
  FactoryGirl.create(:rating, score: score, beer: beer)
end

def create_multiple_breweries
  breweries = ["Koff", "Karjala", "Schlenkerla"]
  year = 1896
  breweries.each do |brewery_name|
    FactoryGirl.create(:brewery, name: brewery_name, year: year += 1, active: 1)
  end
  return breweries
end

def set_configurations_for_js_tests
  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end
end
