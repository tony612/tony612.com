# Ubuntu
namespace :env do
  task :production => [:environment] do
    set :domain,              'tony612.com'
    set :deploy_to,           '/var/www/tony612.com'
    set :sudoer,              'tony'
    set :user,                'tony'
    set :group,               'tony'
    set :rvm_string,          '2.1.1'
    # set :rvm_path,          '/usr/local/rvm/scripts/rvm'   # we don't use that. see below.
    set :services_path,       '/usr/local/etc/rc.d'          # where your God and Unicorn service control scripts will go
    set :nginx_path,          '/etc/nginx'
    set :deploy_server,       'production'                   # just a handy name of the server
    invoke :defaults                                         # load rest of the config
    invoke :"rvm:use[#{rvm_string}]"                       # since my prod server runs 1.9 as default system ruby, there's no need to run rvm:use
  end
end

