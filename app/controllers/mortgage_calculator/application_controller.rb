module MortgageCalculator
  class ApplicationController < MortgageCalculator.parent_controller.constantize
    protect_from_forgery

    layout 'mortgage_calculator/application'

    helper 'mortgage_calculator/ui_components'
  end
end
