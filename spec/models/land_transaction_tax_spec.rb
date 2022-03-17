require 'spec_helper'

describe MortgageCalculator::LandTransactionTax do
  describe 'default state' do
    it 'sets price to zero' do
      expect(subject.price).to be_zero
    end

    it 'sets buyer_type to standard by default' do
      expect(subject.buyer_type).to eq('isNextHome')
    end
  end

  describe '#second_home?' do
    subject { described_class.new(buyer_type: buyer_type) }

    context 'when is next home' do
      let(:buyer_type) { 'isNextHome' }

      it 'is false' do
        expect(subject).not_to be_second_home
      end
    end

    context 'when is second home' do
      let(:buyer_type) { 'isSecondHome' }

      it 'is true' do
        expect(subject).to be_second_home
      end
    end
  end

  it_should_behave_like 'currency inputs', [:price]

  describe 'validations' do
    let(:buyer_type) { 'isNextHome' }

    subject { described_class.new(price: price, buyer_type: buyer_type) }

    context 'when house price is text' do
      let(:price) { 'asd' }

      it 'has errors' do
        subject.valid?
        expect(subject.errors).not_to be_empty
      end
    end
  end

  scenarios = [
    # TO DO rounding errors on 467_895
    { price: 0,       buyer_type:   'isSecondHome', phase: :phase_3, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 0 },
    { price: 39_000,  buyer_type:   'isSecondHome', phase: :phase_3, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 39_000 },
    { price: 40_000,  buyer_type:   'isSecondHome', phase: :phase_3, tax_due: 1_600,  percentage_tax: 4,   precision: 0, total_due: 41_600 },
    { price: 145_000, buyer_type:   'isSecondHome', phase: :phase_3, tax_due: 5_800,  percentage_tax: 4,   precision: 0, total_due: 150_800 },
    { price: 185_000, buyer_type:   'isSecondHome', phase: :phase_3, tax_due: 7_575,  percentage_tax: 4.094594594594595, precision: 0.1,  total_due: 192_575 },
    { price: 275_000, buyer_type:   'isSecondHome', phase: :phase_3, tax_due: 14_700, percentage_tax: 5.345454545454545, precision: 0.01, total_due: 289_700 },
    { price: 300_000, buyer_type:   'isSecondHome', phase: :phase_3, tax_due: 16_950, percentage_tax: 5.64,              precision: 0.1,  total_due: 316_950 },
    { price: 490_000, buyer_type:   'isSecondHome', phase: :phase_3, tax_due: 36_300, percentage_tax: 7.408163265306122, precision: 0.01, total_due: 526_300 },
    { price: 510_000, buyer_type:   'isSecondHome', phase: :phase_3, tax_due: 38_600, percentage_tax: 7.568627450980392, precision: 0.01, total_due: 548_600 },
    { price: 937_500, buyer_type:   'isSecondHome', phase: :phase_3, tax_due: 92_450, percentage_tax: 9.861333333333333, precision: 0.01, total_due: 1_029_950 },
    { price: 2_100_000, buyer_type: 'isSecondHome', phase: :phase_3, tax_due: 267_200, percentage_tax: 12.723809523809524, precision: 0.01, total_due: 2_367_200 },

    { price: 39_000,  buyer_type: 'isNextHome', phase: :phase_3, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 39_000 },
    { price: 40_000,  buyer_type: 'isNextHome', phase: :phase_3, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 40_000 },
    { price: 179_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 179_000 },
    { price: 190_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 350,  percentage_tax: 0.18,   precision: 0.1, total_due: 190_350 },
    { price: 260_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 2950,  percentage_tax: 1.13,   precision: 0.1, total_due: 262_950 },
    { price: 333_333, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 6616.65,  percentage_tax: 1.98,   precision: 0.1, total_due: 339_949.65 },
    { price: 467_895, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 15042.125,  percentage_tax: 3.21,   precision: 0.1, total_due: 482_937.125 },
    { price: 800_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 41200,  percentage_tax: 5.15,   precision: 0.1, total_due: 841_200 },
    { price: 2_000_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 171200,  percentage_tax: 8.56,   precision: 0.1, total_due: 2_171_200 }
  ]

  describe 'calculation scenarios' do
    scenarios.each do |scenario|
      context_name = case scenario[:buyer_type]
                     when 'isFTB'
                       'and is first time buy'
                     when 'isNextHome'
                       'and is not a second home'
                     when 'isSecondHome'
                       'and is a second home'
                     end

      context "When house price is #{scenario[:price]} #{context_name}" do
        subject { described_class.new(price: scenario[:price], buyer_type: scenario[:buyer_type]) }

        its(:tax_due) { is_expected.to (scenario[:tax_due] == 0 ? be_zero : eq(scenario[:tax_due])) }

        its(:percentage_tax) do
          is_expected.to (
          if scenario[:percentage_tax] == 0
            be_zero
          elsif scenario[:percentage_tax] != 0 && scenario[:precision] != 0
            be_within(scenario[:precision]).of(scenario[:percentage_tax])
          else
            eq(scenario[:percentage_tax])
          end
        )
        end
        its(:total_due) { is_expected.to (scenario[:total_due] == 0 ? be_zero : eq(scenario[:total_due])) }
      end
    end
  end
end
