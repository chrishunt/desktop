require 'bundler/gem_tasks'

desc 'Run all tests'
task :test do
  $LOAD_PATH.unshift 'test'
  Dir.glob('./test/**/*_test.rb') { |f| require f }
end

desc 'Open an irb session preloaded with this library'
task :console do
  sh 'irb -rubygems -I lib -r desktop.rb'
end

task default: :test
