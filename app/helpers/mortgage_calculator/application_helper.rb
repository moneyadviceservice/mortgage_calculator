module MortgageCalculator
  module ApplicationHelper
    # Feedback does not appear to inject itself
    include Mas::Feedback::ApplicationHelper

    def zendesk_stamp_duty_config
      @zendesk_stamp_duty_config ||= MortgageCalculator.feedback_config[:stamp_duty]
    end

    def zendesk_affordability_config
      @zendesk_affordability_config ||= MortgageCalculator.feedback_config[:affordability]
    end
  end
end
