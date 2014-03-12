MortgageCalculator::Engine.routes.draw do
  root to: "home#index"

  resource :stamp_duty
  resource :affordability
  resource :repayment do
    collection do
      get 'next_steps'
    end
  end
end
