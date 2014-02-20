module MortgageCalculator
  class AffordabilitiesController < ApplicationController
    def show
      people = [Person.new, Person.new]

      @affordability = ::MortgageCalculator::Affordability.new(people)
    end
  end
end
