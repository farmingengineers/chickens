source 'https://rubygems.org'

ruby "2.1.9"

gem 'rails', '4.1.16'
gem 'unicorn'

gem 'protected_attributes'

# temporary, until i update ruby
gem 'rake', '10.0.3'
gem 'rack-cache', '1.2'
gem 'ffi', '1.12'
gem 'minitest', '5.1'

gem 'sass-rails'
gem 'uglifier', '>= 1.0.3'

gem 'jquery-rails'
gem 'devise', '3.5.10'
gem 'decent_exposure', '2.3.3'
gem 'rails_12factor'

group :development do
  gem 'letter_opener'
  gem 'spring', '1.7.2' # can be 2.1.1 when i update ruby
end

group :development, :test do
  gem 'rspec-rails'
  gem 'sqlite3'
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
