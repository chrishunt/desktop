require 'bundler/gem_tasks'

desc 'Run all tests'
task :test do
  $LOAD_PATH.unshift 'test'
  Dir.glob('./test/**/*_test.rb') { |f| require f }
end

task default: :test
