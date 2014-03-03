module MortgageCalculator
  module ApplicationHelper
    # Feedback does not appear to inject itself
    include Mas::Feedback::ApplicationHelper

    def zendesk_stamp_duty_config
      return @zendesk_stamp_duty_config if @zendesk_stamp_duty_config

      @zendesk_stamp_duty_config = MortgageCalculator.feedback_config[:stamp_duty]
    end
  end
end
