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
  gem 'rspec_junit_formatter'
  gem 'simplecov', :require => false
  gem 'sqlite3'

  # Capybara workaround currently breaking everything, try removing and run `rake routes`
  # @todo: investigate and unpin
  # https://github.com/jnicklas/capybara/commit/385a7507f6525d9b2d1e23bef0bb2e6fe5ad0c97
  gem "capybara", "2.4.1"

  gem 'mas-templating'
end

group :build, :test do
  gem 'mas-build', '~> 2.0'
end

group :build, :test, :development do
  gem 'bowndler'
end
