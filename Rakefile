task :server do
  server = 'puma'
  port = ENV['PORT'] || 4000
  env = ENV['RACK_ENV'] || 'development'
  exec("bundle exec rerun -- rackup --server #{server} --port #{port} --env #{env}")
end

task default: :server
