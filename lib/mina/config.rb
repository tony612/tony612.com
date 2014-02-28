namespace :config do
  desc "Upload config files"
  task :upload => [:'upload:database']

  namespace :upload do
    desc "Upload database.yml"
    task :database do
      upload_file 'Database yaml config', 'database.yml.example', "#{config_path}/database.yml"
    end
  end
end
