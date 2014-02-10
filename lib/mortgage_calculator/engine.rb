require 'mas/assets'

module MortgageCalculator
  class Engine < ::Rails::Engine
    isolate_namespace MortgageCalculator
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
