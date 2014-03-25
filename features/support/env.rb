
ENV["RAILS_ROOT"] ||= File.dirname(__FILE__) + "../../../spec/dummy"

require 'mas/development_dependencies/cucumber/env'

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

