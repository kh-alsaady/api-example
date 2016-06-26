# The server-based syntax can be used to override options:
# ------------------------------------
set :branch, 'dev'
set :keep_releases, 3


server '54.200.86.42',
  user: 'ec2-user',
  roles: %w{web app db},
  ssh_options: {
    user: 'ec2-user', # overrides user setting above
    keys: %w(~/.ssh/id_rsa),
    forward_agent: false,
    auth_methods: %w(publickey)
    # password: 'please use keys'
  }


namespace :deploy do

  %w[start stop restart].each do |command|
    desc 'Manage Unicorn'
    task command do
      on roles(:app), in: :sequence, wait: 1 do
        execute "/etc/init.d/unicorn_api_examples #{command}"
      end      
    end
  end

  after :publishing, :restart

end