module MortgageCalculator
  class ApplicationController < Engine.config.parent_controller.constantize
    protect_from_forgery

    include MAS::Templating::ControllerConcerns::ParentTemplateSupport

    layout 'mortgage_calculator/application'

    parent_template :embedded

    def tool_name
      I18n.t('tool_name')
    end
  end
end
