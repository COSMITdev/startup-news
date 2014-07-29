source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.1.4'
gem 'rails-i18n', '~> 4.0.2'

gem 'thin', '~> 1.6.0'

# For cookie and session store
gem 'activerecord-session_store'

gem 'devise', '~> 3.2.4'
gem 'activeadmin', github: 'gregbell/active_admin'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.17.1'

# Use edge version of sprockets-rails
gem 'sprockets-rails', '~> 2.0.0'
gem 'asset_sync', '~> 1.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use slim templates
gem 'slim-rails', '~> 2.1.5'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Twitter bootstrap
gem 'bootstrap-sass-rails', '~> 3.0.2.1'

# Simple form for form wrappers
gem 'simple_form', '~> 3.0.1'

# Kaminari gem for pagenating searchs and scopes
gem 'kaminari', '~> 0.15.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Preview emails on development enviroment
gem 'letter_opener'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.5.1'

# Google analyticis gem
gem "google-analytics-rails", "~> 0.0.4"

gem 'newrelic_rpm'

# Friendly URL
gem 'friendly_id', '~> 5.0.0'

# Omniauths
gem 'omniauth'
gem 'omniauth-facebook'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :prodution do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'pry-rails', '~> 0.3.2'
  gem 'rspec-rails', '~> 2.0'
  gem 'machinist', '~> 2.0'
end

group :test do
  gem 'database_cleaner', '~> 1.2.0'
  gem 'shoulda-matchers', '~> 2.4.0'
  gem 'coveralls', '~> 0.7.0', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
