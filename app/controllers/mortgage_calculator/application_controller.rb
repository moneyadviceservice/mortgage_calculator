module MortgageCalculator
  class ApplicationController < MortgageCalculator.parent_controller.constantize
    protect_from_forgery

    layout 'mortgage_calculator/application'

    helper 'mortgage_calculator/ui_components'
    helper_method :disable_responsiveness?

    def show_update_banner?
      false
    end
    helper_method :show_update_banner?

    protected

    def disable_responsiveness?
      return super if defined?(super)

      false
    end
  end
end
