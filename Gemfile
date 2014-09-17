source "http://gems.test.mas"
source "https://rubygems.org"

gemspec

gem 'mas-development_dependencies', '~> 2.2'

group :test do
  gem 'rspec', '~> 3.0'
  gem 'rspec-rails', '~> 3.0'
  gem 'rspec-its'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', "2.7.0"
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'rspec_junit_formatter'
  gem 'simplecov', :require => false
  gem 'sqlite3'

  gem 'mas-templating'
end

group :build, :test do
  gem 'mas-build', '~> 2.0'
end

group :build, :test, :development do
  gem 'bowndler'
end
