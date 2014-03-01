# source 'https://rubygems.org'
source 'http://ruby.taobao.org'

gem "rails", "~> 4.0.3"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'slim-rails', '~> 2.0.4'
gem 'jquery-rails', '~> 3.0.4'
gem "simple_form", "~> 3.0.1"
gem 'redcarpet', '~> 3.0.0'
gem "pygments.rb", "~> 0.4.2"
gem 'kaminari', '~> 0.15.1'
gem 'bourbon', '~> 3.1.8'
gem 'gravatar_image_tag', '~> 1.2.0'
gem 'font-awesome-sass', '~> 4.0.2'
gem "rails_warden", "~> 0.5.8"

# New Relic provides you with deep information about the performance of your web application as it runs in production
# https://github.com/newrelic/rpm
gem "newrelic_rpm", "~> 3.6.6.147"

gem 'omniauth-github', :git => 'git://github.com/intridea/omniauth-github.git'

gem "figaro", "~> 0.7.0"
gem 'annotate', ">=2.6.0"

# Deploy
#gem "capistrano", "~> 2.14.2"

# RVM with capistrano
#gem "rvm-capistrano"

# For rails 4
gem 'turbolinks', "~> 2.2.1"

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'thin', "~> 1.5.1"
  gem "factory_girl_rails", "~> 4.0"
   gem 'guard-rspec', require: false
  #gem 'faker'
  gem 'pry-debugger', "~> 0.2.2"
  gem 'pry-rails', "~> 0.2.2"
end

group :production do
  gem 'pg', '~> 0.15.1'
  gem "unicorn"
  gem 'god'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails", "~> 4.0.1"
  gem "coffee-rails", "~> 4.0.1"

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', "~> 0.10.2", :platforms => :ruby

  gem 'uglifier', "~> 2.1.2"
end
