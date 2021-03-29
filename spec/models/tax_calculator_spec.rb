require 'spec_helper'

module MortgageCalculator
  describe TaxCalculator do
    subject { described_class.new(completion_date: completion_date) }

    describe 'validations' do
      context 'when it is valid Date' do
        let(:completion_date) { Date.tomorrow }

        it 'is valid' do
          expect(subject).to be_valid
        end
      end

      context 'when it is a valid Time' do
        let(:completion_date) { Time.zone.now.tomorrow }

        it 'is valid' do
          expect(subject).to be_valid
        end
      end

      context 'when it is invalid' do
        let(:completion_date) { nil }

        it 'is not valid' do
          expect(subject).not_to be_valid
        end
      end

      context 'when it is in the past' do
        let(:completion_date) { Date.yesterday }

        it 'is not valid' do
          expect(subject).not_to be_valid
        end
      end
    end
  end
end
