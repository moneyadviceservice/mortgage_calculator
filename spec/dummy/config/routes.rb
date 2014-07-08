Rails.application.routes.draw do
  scope "/:locale", :locale => /en|cy/ do
    mount MortgageCalculator::Engine => "/mortgage_calculator"
  end

  root to: "home#index"
end

