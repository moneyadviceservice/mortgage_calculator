MortgageCalculator::Engine.routes.draw do
  root to: "home#index"

  resource :stamp_duty
  resource :affordability
end
