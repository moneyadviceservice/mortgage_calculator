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
      outgoings = Outgoings.new

      @affordability = ::MortgageCalculator::Affordability.new(people, outgoings)

      unless @affordability.valid?
        render :show
      end
    end
  end
end

