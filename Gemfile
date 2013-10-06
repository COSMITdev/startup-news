source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'arel', '~> 4.0.0'

gem 'thin', '~> 1.6.0'

gem 'devise', '~> 3.1.1'
gem 'activeadmin', github: 'gregbell/active_admin'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.17.0'

# Use edge version of sprockets-rails
gem 'sprockets-rails', '~> 2.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.2.1'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Twitter bootstrap
gem 'bootstrap-sass-rails', '~> 3.0.0.3'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.5.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :prodution do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'machinist', '~> 2.0'
end

group :test do
  gem 'database_cleaner', '~> 1.1.1'
  gem 'shoulda-matchers', '~> 2.4.0'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
