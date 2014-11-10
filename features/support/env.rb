ENV["RAILS_ROOT"] ||= File.dirname(__FILE__) + "../../../spec/dummy"

require 'cucumber/rails'

require 'capybara'
require 'capybara-screenshot'
require 'capybara-screenshot/cucumber'
require 'capybara/poltergeist'
require 'site_prism'
require 'timecop'

Time.zone = 'London'

ActionController::Base.allow_rescue = false

if defined?(ActiveRecord)
  DatabaseCleaner.strategy                      = :transaction
  Cucumber::Rails::Database.javascript_strategy = :truncation
else
  Cucumber::Rails::Database.autorun_database_cleaner = false
end

if defined?(FactoryGirl)
  Dir[Rails.root.join('./../factories/**/*.rb')].each { |f| require f }
  World(FactoryGirl::Syntax::Methods)
end

Capybara.javascript_driver = :poltergeist

After do
  Timecop.return
end

SitePrism.configure do |config|
  config.use_implicit_waits = true
end
