module MortgageCalculator
  module PhaseHelper
    def phase
      case
      when Date.today < Date.new(2021, 7, 1)
        :phase_1
      when Date.today < Date.new(2021, 10, 1)
        :phase_2
      else
        :phase_3
      end
    end
  end
end
