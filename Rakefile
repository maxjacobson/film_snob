require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:style)

task :todos do
  # This tool requires keyword arguments
  if RUBY_VERSION >= "2.0.0"
    require "todo_lint"
    TodoLint::Cli.new([]).run!
  end
end

task :ci => [:spec, :style, :todos]
task :default => :ci
