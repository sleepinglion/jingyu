set :application, "jingyu"
set :repo_url, "git@github.com:sleepinglion/jingyu.git"
set :branch, 'main'
set :deploy_to, '/home/deploy/jingyu'

# set :format, :pretty
# set :log_level, :debug
#set :pty, true
set :linked_files, %w{config/database.yml config/master.key .env .ruby-version}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/assets public/uploads}

set :rbenv_type, :user
set :rbenv_ruby, "3.3.4"
set :ssh_options, verify_host_key: :never
set :default_env, {'NODE_OPTIONS'=>'--openssl-legacy-provider'}
set :bundle_path, '/usr/local/bundle'

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rake, 'tmp:clear'
      end
    end
  end

  desc 'Refresh sitemap'
  task :refresh_sitemap do
    on roles(:app), in: :sequence, wait: 1 do
      within release_path do
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
          execute :rake, 'sitemap:refresh'
        end
      end
    end
  end

  after :finishing, 'deploy:refresh_sitemap'
  after :finishing, 'deploy:cleanup'
end
