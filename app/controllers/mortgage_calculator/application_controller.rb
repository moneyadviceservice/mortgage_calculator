module MortgageCalculator
  class ApplicationController < MortgageCalculator.parent_controller.constantize
    protect_from_forgery

    layout 'mortgage_calculator/application'

    def tool_name
      I18n.t('mortgage_calculator.tool_name')
    end
  end
end
