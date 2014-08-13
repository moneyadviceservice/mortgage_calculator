
ENV["RAILS_ROOT"] ||= File.dirname(__FILE__) + "../../../spec/dummy"

require 'mas/development_dependencies/cucumber/env'

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

