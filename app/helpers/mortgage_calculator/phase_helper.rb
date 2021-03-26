module MortgageCalculator
  module PhaseHelper
    def phase
      case
      when completion_date < Date.new(2021, 7, 1)
        :phase_1
      when completion_date < Date.new(2021, 10, 1)
        :phase_2
      else
        :phase_3
      end
    end

    def phase_end
      case
      when completion_date < Date.new(2021, 7, 1)
        Date.new(2021, 6, 30)
      when completion_date < Date.new(2021, 10, 1)
        Date.new(2021, 9, 30)
      else
        nil
      end
    end
  end
end
