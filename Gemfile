source "http://gems.dev.mas.local"
source "https://rubygems.org"

gemspec

gem 'rails', '~> 4.2.0'

gem 'bowndler'
gem 'mas-build', '~> 2.0'  if ENV['MAS_BUILD']
gem 'mas-development_dependencies', '2.3.0.35'
gem 'meta-tags'

group :test do
  gem 'capybara'
  gem 'coffee-rails'
  gem 'factory_girl_rails'
  gem 'mas-templating'
  gem 'rspec-its'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', "2.7.0"
  gem 'simplecov', :require => false
  gem 'sqlite3'
end
