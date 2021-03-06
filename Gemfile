# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.4.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'hashie'

gem 'angularjs-rails'

gem 'encode_with_alphabet'

gem 'nokogiri'

gem 'font-awesome-rails'

gem 'twitter'

gem 'rollbar'

gem 'rspotify'

gem 'genius'

gem 'rubocop', require: false

group :production do
  gem 'heroku-deflater'
  gem 'pg', '~> 0.20'
  gem 'rails_12factor'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.3.6'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'pry'

  gem 'jasmine-rails'
end

group :test do
  gem 'spring-commands-rspec'

  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-rails', require: false
  gem 'guard-rspec', require: false
  gem 'rails-controller-testing'
  gem 'rspec'
  gem 'rspec-rails'

  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'

  gem 'timecop'
end

group :test, :darwin do
  gem 'rb-fsevent'
end
