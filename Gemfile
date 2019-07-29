source 'https://rubygems.org'

ruby "2.1.9"

gem 'rails'
gem 'unicorn'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml-rails'
gem 'devise', '~> 2.1.0'
gem 'decent_exposure'
gem 'rails_12factor'

group :development do
  gem 'letter_opener'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'sqlite3', '~> 1.3.5'
  gem 'byebug'
end

group :production do
  gem 'pg'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'
