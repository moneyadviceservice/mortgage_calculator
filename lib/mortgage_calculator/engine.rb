require 'mas/assets'
require 'sass-rails'
require 'jquery-rails'
require 'angularjs-rails'
require 'underscore-rails'
require 'mas/feedback'

module MortgageCalculator
  class Engine < ::Rails::Engine
    isolate_namespace MortgageCalculator
    config.generators do |g|
      g.test_framework :rspec
    end

    config.after_initialize do |app|
      app.config.paths.add 'app/decorators', eager_load: true
    end
  end
end
