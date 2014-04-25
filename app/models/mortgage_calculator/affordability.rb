module MortgageCalculator
  class Affordability
    include CurrencyInput::Macro
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_reader :people

    validate :validate_people

    def people_attributes=(attributes)
    end

    def initialize(people)
      @people = people
    end

    def total_income
      @total_income ||= people.map(&:total_income).inject(:+)
    end

    def number_of_applicants
      people.length
    end

    def to_key
      nil
    end

    def persisted?
      false
    end

    def can_borrow_upto
      0
    end

    def can_borrow_from
      0
    end

  private

    def validate_people
      people.each do |person|
        unless person.valid?
          person.errors.each do |error|
            errors.add(:base, error)
          end
        end
      end
    end

    def lower_profit_multiplier
      3
    end

    def upper_profit_multiplier
      4
    end
  end
end
