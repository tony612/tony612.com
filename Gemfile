# source 'https://rubygems.org'
source 'http://ruby.taobao.org'

gem "rails", "~> 4.0.0"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'slim-rails', '~> 2.0.1'
gem 'jquery-rails', '~> 3.0.4'
gem "simple_form", "~> 3.0.0.rc"
gem "devise", "~> 3.0.2"
gem 'redcarpet', '~> 3.0.0'
gem "pygments.rb", "~> 0.4.2"
gem 'kaminari', '~> 0.14.1'

# Deploy
#gem "capistrano", "~> 2.14.2"

# RVM with capistrano
#gem "rvm-capistrano"

# For rails 4
gem 'turbolinks', "~> 1.3.0"

group :development, :test do
  gem 'sqlite3'
  #gem 'rspec-rails'
  gem 'thin', "~> 1.5.1"
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
  gem "sass-rails", "~> 4.0.0"
  gem "coffee-rails", "~> 4.0.0"

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', "~> 0.10.2", :platforms => :ruby

  gem 'uglifier', "~> 2.1.2"
end
