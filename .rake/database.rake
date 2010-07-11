namespace :postgresql do
  desc "Init database cluster and start daemon."
  task :start do
    cluster_dir = '/var/tmp/postgresql-cluster'
    bash "rm -rf #{cluster_dir}"
    bash "/usr/lib/postgresql/8.4/bin/initdb -A trust -D #{cluster_dir}"
    bash "/usr/lib/postgresql/8.4/bin/postgres -D #{cluster_dir} -c unix_socket_directory='#{cluster_dir}'"
  end
end

def bash(commandline)
  system "#{ENV['SHELL']} -c '#{commandline}'"
end
