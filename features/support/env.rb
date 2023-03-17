ENV["RAILS_ROOT"] ||= File.dirname(__FILE__) + "../../../spec/dummy"

require 'cucumber/rails'

require 'capybara'
require 'capybara/poltergeist'
require 'site_prism'

Time.zone = 'London'

ActionController::Base.allow_rescue = false

Cucumber::Rails::Database.autorun_database_cleaner = false

Capybara.javascript_driver = :poltergeist

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

def step_one
  UI::Pages::Affordability::StepOne.new
end

def step_two
  UI::Pages::Affordability::StepTwo.new
end

def step_three
  UI::Pages::Affordability::StepThree.new
end

def next_steps
  UI::Pages::Affordability::NextSteps.new
end

def calculations
  require 'yaml'

  examples = YAML.load_file(
    Rails.root.join('../../spec/fixtures/calculations.yml').to_s
    )
end
