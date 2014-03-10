module MortgageCalculator
  class ApplicationController < Engine.config.parent_controller.constantize
    protect_from_forgery

    include MAS::Templating::ControllerConcerns::ParentTemplateSupport

    layout 'mortgage_calculator/application'

    parent_template :embedded

    def tool_name
      "mortgage-calculator-beta"
    end
  end
end
