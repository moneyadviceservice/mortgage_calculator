source "http://gems.dev.mas.local"
source "https://rubygems.org"

gemspec

gem 'rails', '4.2.10'

gem 'bowndler'
gem 'mas-build', '~> 2.0'  if ENV['MAS_BUILD']
gem 'mas-development_dependencies', '2.3.0.35'
gem 'meta-tags'

group :test, :development do
  gem 'byebug'
  gem 'rubocop', require: false
end

group :test do
  gem 'brakeman', require: false
  gem 'capybara'
  gem 'coffee-rails'
  gem 'cucumber', '~> 3.0.1'
  gem 'mas-templating'
  gem 'rspec-its'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'sqlite3'
  gem 'tzinfo-data'
end
