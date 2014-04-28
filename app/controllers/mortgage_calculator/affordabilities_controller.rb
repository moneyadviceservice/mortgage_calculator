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

      @affordability = ::MortgageCalculator::Affordability.new(people, outgoings)
      @repayment = Repayment.new(price: @affordability.borrowing)

      unless @affordability.valid?
        render :show
      end
    end
  end
end

