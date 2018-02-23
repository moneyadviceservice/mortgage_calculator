class LocaleConstraint
  attr_reader :locale

  def initialize(locale)
    @locale = locale.to_s
  end

  def matches?(request)
    request.params['locale'] == locale
  end
end

MortgageCalculator::Engine.routes.draw do
  root to: "repayments#show"

  resource :repayment do
    collection do
      get 'next_steps'
    end
  end

  resource :stamp_duty, path: 'stamp-duty-calculator'

  resource :stamp_duty, path: 'cyfrifiannell-treth-stamp'

  resource :stamp_duty

  resource :stamp_duty, path: 'treth_stamp'

  resource :land_and_buildings_transaction_tax, path: 'land-and-buildings-transaction-tax-calculator'
  resource :land_and_buildings_transaction_tax, path: 'cyfrifiannell-treth-trafodion-tir-ac-adeiladau'
  resource :land_and_buildings_transaction_tax

  resource :affordability, path: "mortgage-affordability-calculator" do
    get '/', to: "affordabilities#step_1"
    collection do
      match 'step_1', path: "step-1", via: [:get, :post]
      match 'step_2', path: "step-2", via: [:get, :post]
      match 'step_3', path: "step-3", via: [:get, :post]
      get 'next_steps'
    end
  end

  resource :affordability, path: "cyfrifiannell-fforddiadwyedd-morgais", as: 'affordability_cy' do
    get '/', to: "affordabilities#step_1"
    collection do
      match 'step_1', path: "step-1", via: [:get, :post]
      match 'step_2', path: "step-2", via: [:get, :post]
      match 'step_3', path: "step-3", via: [:get, :post]
      get 'next_steps'
    end
  end
end
