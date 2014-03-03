module MortgageCalculator
  module ApplicationHelper
    # Feedback does not appear to inject itself
    include Mas::Feedback::ApplicationHelper

    def zendesk_stamp_duty_config
      contents = File.open(MortgageCalculator::Engine.root.join('config','zendesk.yml')).read
      YAML.load(contents).with_indifferent_access[:stamp_duty]
    end
  end
end
