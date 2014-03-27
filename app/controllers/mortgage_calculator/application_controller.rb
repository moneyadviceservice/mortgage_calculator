module MortgageCalculator
  class ApplicationController < MortgageCalculator.parent_controller.constantize
    protect_from_forgery

    include MAS::Templating::ControllerConcerns::ParentTemplateSupport

    layout 'mortgage_calculator/application'

    parent_template :embedded

    def tool_name
      I18n.t('mortgage_calculator.tool_name')
    end
  end
end
