module MortgageCalculator
  # Load order issue - subclass a class explicitly
  class AffordabilitiesController < ::MortgageCalculator::ApplicationController
    def show
      people = [PersonPresenter.new(Person.new), PersonPresenter.new(Person.new)]

      @affordability = AffordabilityPresenter.new(Affordability.new(people))
    end

    def create
      people = params[:affordability][:people_attributes].values.map{|p| Person.new(p)}

      @affordability = ::MortgageCalculator::Affordability.new(people)

      unless @affordability.valid?
        render :show
      end
    end
  end
end

