source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
gem 'bundler', '>= 1.8.4'
gem 'angularjs-rails'

group :development, :test do
  gem 'sqlite3'
end

group :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'webmock'
  gem 'selenium-webdriver'
  gem 'database_cleaner', '< 1.1.0'
  gem 'coveralls', require: false
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'jquery-turbolinks'
gem 'httparty'
gem 'bootstrap_form'
gem 'byebug', group: [:development, :test]

gem 'bootstrap-sass'
group :development do
  gem 'rails_layout'
end

gem 'bcrypt-ruby', '~> 3.1.2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

source 'https://rails-assets.org' do
  gem 'rails-assets-angular-ui-sortable'
end
