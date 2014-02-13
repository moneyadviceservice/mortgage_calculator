require 'mas/assets'
require 'sass-rails'
require 'jquery-rails'
require 'underscore-rails'

module MortgageCalculator
  class Engine < ::Rails::Engine
    isolate_namespace MortgageCalculator
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
