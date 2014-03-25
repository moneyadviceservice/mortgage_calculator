require 'modernizr-rails'
require 'mas/assets'
require 'sass-rails'
require 'jquery-rails'
# require 'jquery-ui-rails'
require 'angularjs-rails'
require 'underscore-rails'
require 'mas/feedback'
require 'mas/templating'

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

    initializer :append_precompile_assets do |app|
      app.config.assets.precompile += %w( mortgage_calculator/basic.css )
    end

    initializer :append_frontend_assets do |app|
      app.config.assets.paths << Engine.root.join("vendor", "assets", "components")
      app.config.assets.paths << Engine.root.join("vendor", "assets", "components", "frontend", "app", "assets", "stylesheets")
      app.config.assets.paths << Engine.root.join("vendor", "assets", "components", "frontend", "vendor", "assets", "fonts")
      app.config.sass.load_paths << Engine.root.join("vendor", "assets", "components", "frontend", "app", "assets", "stylesheets")
      app.config.sass.load_paths << Engine.root.join("vendor", "assets", "components", "frontend", "app", "assets", "stylesheets", "lib")
    end
  end
end
