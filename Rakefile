require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "todo_lint"

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:style)

task :todos do
  TodoLint::Cli.new([]).run!
end

task :ci => [:spec, :style, :todos]
task :default => :ci
