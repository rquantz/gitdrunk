namespace :pg do
  task :start do
    sh "pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
  end
  task :stop do
    sh "pg_ctl -D /usr/local/var/postgres stop -s -m fast"
  end
  task :download do
    sh "curl -o latest.dump `heroku pgbackups:url`"
  end
  task :bu do
    sh "heroku pgbackups:capture"
  end
  task :restore do
    sh "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U rq -d cocktails_development latest.dump"
  end
  task :clean do
    sh "rm latest.dump"
  end
  task :sync => [:bu, :download, :restore, :clean]
end
