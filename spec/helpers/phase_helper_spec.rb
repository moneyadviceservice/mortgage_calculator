require 'spec_helper'

module MortgageCalculator
  describe PhaseHelper do
    completion_dates = [Date.new(2021, 7, 1), Date.new(2021, 9, 30), Date.new(2021, 10, 1)]
    completion_phases = %i[phase_2 phase_2 phase_3]
    completion_expectations = completion_dates.zip(completion_phases)

    context 'When calling #phase' do
      completion_expectations.each do |(date, phase)|
        it "returns phase: #{phase} on #{date}" do
          allow(helper).to receive(:completion_date).and_return(date)

          expect(helper.phase).to eq(phase)
        end
      end
    end
  end
end
