source "https://rubygems.org"

gem "rake", "~> 10.4"

gem "rubocop", "~> 0.39"
gem "todo_lint", "~> 0.2"
gem "rspec", "~> 3.4"
gem "webmock", "~> 1.22"
gem "vcr", "~> 2.9"
gem "codeclimate-test-reporter", "~> 0.4"

# to be skipped on CI
group :development do
  # TDD workflow
  gem "guard"
  gem "guard-rspec"
  gem "guard-rubocop"

  gem "pry", "~> 0.10"
end

# Specify your gem's dependencies in film_snob.gemspec
gemspec
