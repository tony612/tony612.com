###########################################################################
# God
###########################################################################

namespace :god do
  desc "Create necessary files"
  task :setup do
    queue 'echo "-----> Create God configs path"'
    queue echo_cmd "mkdir -p #{config_path}/god"
  end

  desc "Upload and update (link) all God config files"
  task :update => [:upload, :link]

  desc "Relocate god script file"
  task :link do
    invoke :sudo
    queue 'echo "-----> Relocate god script file"'
    queue echo_cmd %{sudo cp "#{config_path}/god.sh" "#{god_script}" && sudo chown #{god_user}:#{god_group} #{god_script} && sudo chmod u+x #{god_script}}
    queue check_ownership god_user, god_group, god_script
  end

  desc "Parses all God config files and uploads them to server"
  task :upload => [:'upload:script', :'upload:global', :'upload:unicorn']

  namespace :upload do
    desc "Parses God control script file and uploads it to server"
    task :script do
      upload_template 'God control script', 'god.sh', "#{config_path}/god.sh"
    end

    desc "Parses God global config file and uploads it to server"
    task :global do
      upload_template 'God global config', 'global.god', god_global
    end

    desc "Parses Unicorn God config file and uploads it to server"
    task :unicorn do
      upload_template 'Unicorn God config', 'god/unicorn.god', god_unicorn
    end
  end

  desc "Parses all God config files and shows them in output"
  task :parse => [:'parse:script', :'parse:global', :'parse:unicorn']

  namespace :parse do
    desc "Parses Unicorn control script file and shows it in output"
    task :script do
      puts "#"*80
      puts "# god.sh"
      puts "#"*80
      puts erb("#{config_templates_path}/god.sh.erb")
    end

    desc "Parses Unicorn God config file and shows it in output"
    task :global do
      puts "#"*80
      puts "# global.god"
      puts "#"*80
      puts erb("#{config_templates_path}/global.god.erb")
    end

    desc "Parses Unicorn god config file and shows it in output"
    task :unicorn do
      puts "#"*80
      puts "# god/unicorn.god"
      puts "#"*80
      puts erb("#{config_templates_path}/god/unicorn.god.erb")
    end
  end

  %w(stop start restart status).each do |action|
    desc "#{action.capitalize} God"
    task action.to_sym do
      queue %{echo "-----> #{action.capitalize} God"}
      queue echo_cmd "#{god_script} #{action}"
    end
  end
end
