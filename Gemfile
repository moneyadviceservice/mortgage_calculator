source "http://gems.test.mas"
source "http://rubygems.org"

gemspec

gem 'rails', '~>3.2.14'

gem 'mas-development_dependencies'

group :test do
  gem 'rspec'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', "2.5.0"
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
