module MortgageCalculator
  class ApplicationController < ActionController::Base
    protect_from_forgery

    include MAS::Templating::ControllerConcerns::ParentTemplateSupport

    layout 'mortgage_calculator/application'

    parent_template :embedded
  end
end
