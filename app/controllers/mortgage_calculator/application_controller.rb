module MortgageCalculator
  class ApplicationController < MortgageCalculator.parent_controller.constantize
    protect_from_forgery

    layout 'mortgage_calculator/application'
  end
end
