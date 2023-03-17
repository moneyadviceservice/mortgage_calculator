source 'https://gem.fury.io/h_app288206558'
source "https://rubygems.org"

gemspec

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby IO.read('.ruby-version').strip

source "https://gems.railslts.com" do
  gem 'rails', '~> 4.2.11.30'
  gem 'actionmailer',     require: false
  gem 'actionpack',       require: false
  gem 'activemodel',      require: false
  gem 'activerecord',     require: false
  gem 'activesupport',    require: false
  gem 'railties',         require: false
  gem 'actionview',       require: false
  gem 'activejob',        require: false
  gem 'railslts-version', require: false
end

gem 'bigdecimal', '1.3.5'
gem 'bowndler', git: 'https://github.com/moneyadviceservice/bowndler'
gem 'dough-ruby', github: 'moneyadviceservice/dough', branch: 'PostMessages_v5.45', ref: '0bf4b23a'
gem 'meta-tags'

group :test, :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'danger', require: false
  gem 'danger-rubocop', require: false
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rb-readline'
  gem 'rubocop', '0.80.0', require: false
  gem 'rubocop-rspec'
end

group :test do
  gem 'capybara', '2.18.0'
  gem 'coffee-rails'
  gem 'cucumber', '~> 3.0.1'
  gem 'cucumber-rails', '1.6.0', require: false
  gem 'launchy'
  gem 'mas-templating'
  gem 'multi_test', '0.1.2'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'rspec-its'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'site_prism', '2.11'
  gem 'sqlite3'
  gem 'tzinfo-data'
end
