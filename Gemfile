source "http://gems.dev.mas.local"
source "https://rubygems.org"

gemspec

gem 'bowndler'
gem 'mas-build', '~> 2.0'  if ENV['MAS_BUILD']
gem 'mas-development_dependencies', '2.3.0.35'
gem 'meta-tags'

group :test do
  # Capybara workaround currently breaking everything, try removing and run `rake routes`
  # @todo: investigate and unpin
  # https://github.com/jnicklas/capybara/commit/385a7507f6525d9b2d1e23bef0bb2e6fe5ad0c97
  gem "capybara", "2.4.1"
  gem 'coffee-rails'
  gem 'factory_girl_rails'
  gem 'mas-templating'
  gem 'rspec', '~> 3.0'
  gem 'rspec-its'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', "2.7.0"
  gem 'simplecov', :require => false
  gem 'sqlite3'
end
