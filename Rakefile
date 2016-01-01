require 'bundler/gem_tasks'
require 'rake'
require 'rspec/core/rake_task'

task :test do
  sh 'rspec'
  sh 'yard stats --list-undoc'
  sh 'bundle exec ruby -W0 -S rubocop'
end
