require "bundler/gem_tasks"
require "yaml"

task :continuous_integration do
  YAML.load(File.read("./.travis.yml")).fetch("script").shuffle.each do |cmd|
    next if system cmd
    puts "\nFailed: #{cmd.inspect}"
    exit 1
  end
end

task :default => [:continuous_integration]
