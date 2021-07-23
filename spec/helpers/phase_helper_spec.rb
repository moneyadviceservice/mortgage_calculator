require 'spec_helper'

module MortgageCalculator
  describe PhaseHelper do
    COMPLETION_DATES = [ Date.new(2021, 7, 1), Date.new(2021, 9, 30), Date.new(2021, 10, 1) ]
    COMPLETION_PHASES = %i[phase_2 phase_2 phase_3]
    COMPLETION_EXPECTATIONS = COMPLETION_DATES.zip(COMPLETION_PHASES)

    context '#phase' do
      COMPLETION_EXPECTATIONS.each do |(date, phase)|
        it "returns phase: #{phase} on #{date}" do
          allow(helper).to receive(:completion_date).and_return(date)

          expect(helper.phase).to eq(phase)
        end
      end
    end
  end
end