require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--require spec_helper'
end

task :server do
  server = 'puma'
  port = ENV['PORT'] || 4000
  env = ENV['RACK_ENV'] || 'development'
  exec("bundle exec rerun -- rackup --server #{server} --port #{port} --env #{env}")
end

task default: :spec
