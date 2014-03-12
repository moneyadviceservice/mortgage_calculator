require 'mas/assets'
require 'sass-rails'
require 'jquery-rails'
require 'angularjs-rails'
require 'underscore-rails'
require 'mas/feedback'
require 'mas/templating'

module MortgageCalculator
  mattr_accessor :feedback_config

  class Engine < ::Rails::Engine
    isolate_namespace MortgageCalculator
    config.generators do |g|
      g.test_framework :rspec
    end

    config.parent_controller = 'ApplicationController'

    config.after_initialize do |app|
      app.config.paths.add 'app/decorators', eager_load: true
    end

    config.after_initialize do |app|
      contents = File.open(MortgageCalculator::Engine.root.join('config','zendesk.yml')).read
      MortgageCalculator.feedback_config = YAML.load(contents).with_indifferent_access

      Rails.application.config.assets.paths << Engine.root.join("vendor", "assets", "components", "frontend", "app", "assets", "stylesheets")
      Rails.application.config.assets.paths << Engine.root.join("vendor", "assets", "components", "frontend", "vendor", "assets", "fonts")
      Rails.application.config.sass.load_paths << Engine.root.join("vendor", "assets", "components", "frontend", "app", "assets", "stylesheets")
    end
  end
end
