module MortgageCalculator
  # Load order issue - subclass a class explicitly
  class AffordabilitiesController < ::MortgageCalculator::ApplicationController
    def show
      people = [PersonPresenter.new(Person.new), PersonPresenter.new(Person.new)]
      outoings = Outgoings.new

      @affordability = AffordabilityPresenter.new(Affordability.new(people, outoings))
    end

    def create
      people = params[:affordability][:people_attributes].values.map{|p| Person.new(p)}
      outgoings = Outgoings.new(params[:affordability][:outgoings])
      borrowing = params[:affordability][:borrowing]
      lifestyle_costs = params[:affordability][:lifestyle_costs]

      @affordability = ::MortgageCalculator::Affordability.new(people, outgoings, borrowing: borrowing, lifestyle_costs: lifestyle_costs)

      @changer = Repayment.new(price: @affordability.repayment.price, interest_rate: @affordability.repayment.interest_rate)
      @changer.change_interest_rate_by(interest_rate_change_amount)

      unless @affordability.valid?
        render :show
      end
    end

    def next_steps
    end

    private

    def interest_rate_change_amount
      2
    end
    helper_method :interest_rate_change_amount
  end
end

