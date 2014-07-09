require 'modernizr-rails'
require 'sass-rails'
require 'jquery-rails'
require 'angularjs-rails'
require 'underscore-rails'
require 'mas/feedback'
require 'mas/fonts'
require 'dough'

module MortgageCalculator
  mattr_accessor :feedback_config
  mattr_accessor :parent_controller
  mattr_accessor :bug_snag_key

  class Engine < ::Rails::Engine
    isolate_namespace MortgageCalculator
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer :setup_defaults do
      MortgageCalculator.parent_controller ||= 'ApplicationController'
    end

    config.after_initialize do |app|
      app.config.paths.add 'app/decorators', eager_load: true
    end

    config.after_initialize do |app|
      contents = File.open(MortgageCalculator::Engine.root.join('config','zendesk.yml')).read
      MortgageCalculator.feedback_config = YAML.load(contents).with_indifferent_access
    end

    initializer :append_frontend_assets, :group => :all do |app|
      # Asset dependencies loaded in application.html.erb layout file
      app.config.assets.precompile += ['mortgage_calculator/application_fixed.css']
      app.config.assets.precompile += ['mortgage_calculator/application_responsive.css']
      app.config.assets.precompile += ['mortgage_calculator_basic.css']
      app.config.assets.precompile += ['mortgage_calculator_enhanced_fixed.css']
      app.config.assets.precompile += ['mortgage_calculator_enhanced_responsive.css']
      app.config.assets.precompile += ['mortgage_calculator/frontend-assets/stylesheets/font_base64.css']

      app.config.assets.precompile << 'd3.js'
      app.config.assets.precompile << 'r2d3.js'
    end
  end
end
