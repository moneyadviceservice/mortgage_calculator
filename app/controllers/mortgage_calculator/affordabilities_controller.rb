module MortgageCalculator
  class AffordabilitiesController < ApplicationController
    def show
      people = [Person.new, Person.new]

      @affordability = ::MortgageCalculator::Affordability.new(people)
    end

    def create
      people = params[:affordability][:people_attributes].values.map{|p| Person.new(p)}
      monthly_debt = params[:affordability][:monthly_debt]

      @affordability = ::MortgageCalculator::Affordability.new(people, monthly_debt)
    end
  end
end
