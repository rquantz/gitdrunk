namespace :pg do
  task :start do
    sh "pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
  end
  task :stop do
    sh "pg_ctl -D /usr/local/var/postgres stop -s -m fast"
  end
end
