MortgageCalculator::Engine.routes.draw do
  root to: "repayments#show"

  resource :repayment do
    collection do
      get 'next_steps'
    end
  end

  if MortgageCalculator.stamp_duty_enabled
    resource :stamp_duty do
      collection do
        get 'next_steps'
      end
    end
  end
end
