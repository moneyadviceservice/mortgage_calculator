ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment.rb", __FILE__)

require 'shoulda-matchers'
require 'rspec/rails'

Dir[Rails.root.join('./../support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('./../factories/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.infer_base_class_for_anonymous_controllers = false

  config.include FactoryGirl::Syntax::Methods if defined?(FactoryGirl)
  config.include Devise::TestHelpers, :type => :controller if defined?(Devise)

  config.use_transactional_fixtures = true if defined?(ActiveRecord)
  config.order = 'random'
  config.run_all_when_everything_filtered = true

  config.infer_spec_type_from_file_location!

  config.before(:each) do
    I18n.locale = :en if defined?(I18n)
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
