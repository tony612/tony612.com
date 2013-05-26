source 'https://rubygems.org'

gem "rails", "~> 4.0.0.rc1"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'slim-rails'
gem 'jquery-rails'
gem "simple_form", "~> 3.0.0.rc"
gem "devise", "~> 3.0.0.rc"
gem 'redcarpet'
gem "pygments.rb", "~> 0.4.2"
gem 'kaminari'

# Deploy
#gem "capistrano", "~> 2.14.2"

# RVM with capistrano
#gem "rvm-capistrano"

# For rails 4
gem 'turbolinks'

group :development, :test do
  gem 'sqlite3'
  #gem 'rspec-rails'
  gem 'thin'
  #gem 'capybara'
  #gem 'factory_girl_rails'
  #gem 'faker'
  gem 'pry-debugger', "~> 0.2.2"
  gem 'pry-rails', "~> 0.2.2"
end

group :production do
  gem 'pg', '~> 0.15.1'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails", "~> 4.0.0.rc1"
  gem "coffee-rails", "~> 4.0.0"

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end
