source "http://gems.dev.mas.local"
source "https://rubygems.org"

gemspec

gem 'rails', '4.2.10'

gem 'bowndler'
gem 'mas-build', '~> 2.0'  if ENV['MAS_BUILD']
gem 'mas-development_dependencies', '2.3.0.35'
gem 'meta-tags'

group :test, :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'danger', require: false
  gem 'danger-rubocop', require: false
  gem 'rubocop', require: false
end

group :test do
  gem 'brakeman', require: false
  gem 'capybara', '2.18.0'
  gem 'coffee-rails'
  gem 'cucumber', '~> 3.0.1'
  gem 'cucumber-rails', '1.6.0'
  gem 'mas-templating'
  gem 'rspec-its'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'site_prism', '2.11'
  gem 'sqlite3'
  gem 'tzinfo-data'
end
