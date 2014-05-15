require 'modernizr-rails'
require 'sass-rails'
require 'jquery-rails'
require 'angularjs-rails'
require 'underscore-rails'
require 'mas/feedback'
require 'mas/frontend/helpers'

module MortgageCalculator
  mattr_accessor :feedback_config
  mattr_accessor :parent_controller

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
      app.config.assets.paths      << Engine.root.join('vendor', 'assets', 'bower_components')
      app.config.assets.paths      << Engine.root.join('vendor', 'assets', 'bower_components', 'mortgage_calculator')
      app.config.assets.paths      << Engine.root.join('vendor', 'assets', 'bower_components', 'mortgage_calculator', 'frontend-assets')
      app.config.assets.paths      << Engine.root.join('vendor', 'assets', 'bower_components', 'mortgage_calculator', 'frontend-assets', 'stylesheets')
      app.config.assets.paths      << Engine.root.join('vendor', 'assets', 'bower_components', 'mortgage_calculator', 'frontend-assets', 'fonts')
      app.config.assets.paths      << Engine.root.join('vendor', 'assets', 'bower_components', 'mortgage_calculator', 'frontend-assets', 'javascripts')
      app.config.assets.paths      << Engine.root.join('vendor', 'assets', 'javascripts')
      app.config.assets.paths      << Engine.root.join('vendor', 'assets', 'stylesheets')
      app.config.sass.load_paths   << Engine.root.join('vendor', 'assets', 'bower_components', 'mortgage_calculator', 'frontend-assets', 'stylesheets')

      # Asset dependencies loaded in application.html.erb layout file
      app.config.assets.precompile += ['mortgage_calculator/application_fixed.css']
      app.config.assets.precompile += ['mortgage_calculator/application_responsive.css']
      app.config.assets.precompile += ['mortgage_calculator_basic.css']
      app.config.assets.precompile += ['mortgage_calculator_enhanced_fixed.css']
      app.config.assets.precompile += ['mortgage_calculator_enhanced_responsive.css']
      app.config.assets.precompile += ['mortgage_calculator/frontend-assets/stylesheets/font_base64.css']
    end
  end
end
