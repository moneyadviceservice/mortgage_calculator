MortgageCalculator::Engine.routes.draw do
  root to: "repayments#show"

  resource :repayment do
    collection do
      get 'next_steps'
    end
  end

  if Settings.feature_toggles.enable_stamp_duty_calculator?
    resource :stamp_duty
  end
end
