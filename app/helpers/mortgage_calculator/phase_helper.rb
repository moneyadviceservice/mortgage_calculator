module MortgageCalculator
  module PhaseHelper
    def phase
      if completion_date < Date.new(2021, 7, 1)
        :phase_1
      elsif completion_date < Date.new(2021, 10, 1)
        :phase_2
      else
        :phase_3
      end
    end

    def phase_end
      if completion_date < Date.new(2021, 7, 1)
        Date.new(2021, 6, 30)
      elsif completion_date < Date.new(2021, 10, 1)
        Date.new(2021, 9, 30)
      end
    end
  end
end
