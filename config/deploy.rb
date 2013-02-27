require 'rvm/capistrano'

set :rvm_ruby_string, 'ruby-2.0.0-preview1'
set :rvm_type, :user

set :app_server, 'tony612.com'
set :app_url, 'http://tony612.com'

set :application, "tony612.com"
set :repository,  "git@github.com:tony612/tony612.com.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
default_run_options[:pty] = true

# using Agent Forwarding
set :ssh_options, { :forward_agent => true }

#In most cases you want to use this option, otherwise each deploy will do a full repository clone every time.
set :deploy_via, :remote_cache

# If you're using git submodules you must tell cap to fetch them.
set :git_enable_submodules, 1

set :branch, "master"

# bundler bootstrap Running cap deploy will now automatically run bundle install on the remote server with deployment-friendly options. A list of options that can be changed is available in the help for the cap task. To see it, run cap -e bundle:install.
require 'bundler/capistrano'
role :web, app_server                          # Your HTTP server, Apache/etc
role :app, app_server                          # This may be the same as your `Web` server
role :db,  app_server, :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

set :deploy_to, "/var/www/ib5k-web"
set :deploy_via, :remote_cache
set :user, "tony"
set :use_sudo, false

# # Multi stage
# # https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
# # https://github.com/VinceMD/Scem/wiki/Deploying-on-production
# require gem 'capistrano-ext'
# require 'capistrano/ext/multistage'
# set :stages, %w(production staging)
# set :default_stage, "staging" # require config/deploy/staging.rb

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# # integrate whenever
# # when using bundler
# set :whenever_command, "bundle exec whenever"
# # when using different environments
# set :whenever_environment, defer { stage }
# require "whenever/capistrano"
# # https://github.com/javan/whenever/blob/master/lib/whenever/capistrano.rb

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    %w{database}.each do |file|
      run "ln -nfs #{shared_path}/config/#{file}.yml #{release_path}/config/#{file}.yml"
    end

    # link dirs in public/
    %w{uploads}.each do |dir|
      run "mkdir -p #{shared_path}/public/#{dir}"
      run "ln -nfs #{shared_path}/public/#{dir} #{release_path}/public/#{dir}"
    end
  end

  desc "Initialize configuration using example files provided in the distribution"
  task :upload_config do
    %w{config}.each do |dir|
      run "mkdir -p #{shared_path}/#{dir}"
    end

    Dir["config/*.yml.example"].each do |file|
      top.upload(File.expand_path(file), "#{shared_path}/config/#{File.basename(file, '.example')}")
    end
  end
end
