source "http://gems.test.mas"
source "http://rubygems.org"

gemspec

gem 'mas-development_dependencies'

group :test do
  gem 'rspec'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'rspec_junit_formatter'
  gem 'simplecov', :require => false
  gem 'sqlite3'
end

group :build, :test do
  gem 'mas-build', '~> 2.0'
end
