# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'trip'
set :repo_url, 'git@github.com:/vip-take/trip.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# set :branch, 'master'
set :branch, ENV["BRANCH"]

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/home/trip_admin/trip'
set :deploy_to, '/home/trip_admin/trip/'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml'
# set :linked_files, fetch(:linked_files, []).push('config/settings.yml')

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :default_env, {
	ACCESS_KEY_ID_TRIP: ENV['ACCESS_KEY_ID_TRIP'],
	SECRET_ACCESS_KEY_TRIP: ENV['SECRET_ACCESS_KEY_TRIP'],
	SECRET_KEY_BASE: ENV["SECRET_KEY_BASE"],
	DEVISE_SECRET_KEY: ENV["DEVISE_SECRET_KEY"]
}

# Default value for keep_releases is 5
set :keep_releases, 5

set :rbenv_ruby, '2.3.1'

set :log_level, :debug

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

  desc "restart nginx server"
  task :restart do
    on roles(:app) do
    	execute! :sudo, :service, :nginx, :restart
    end
  end

end
