source "http://rubygems.org"

gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

gem 'mas-build', :git => 'git@github.com:moneyadviceservice/mas-build' if ENV['MAS_BUILD']
gem 'mas-assets', :git => 'git@github.com:moneyadviceservice/mas-assets'

gem 'mas-development_dependencies', :git => 'git@github.com:moneyadviceservice/mas-development_dependencies'

group :test do
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'coffee-rails'
  gem 'sass-rails'
end
