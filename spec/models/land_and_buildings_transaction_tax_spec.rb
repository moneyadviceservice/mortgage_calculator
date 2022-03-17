require 'spec_helper'

describe MortgageCalculator::LandAndBuildingsTransactionTax do
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
    { price: 39_000,  buyer_type: 'isFTB', phase: :phase_3, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 39_000 },
    { price: 40_000,  buyer_type: 'isFTB', phase: :phase_3, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 40_000 },
    { price: 120_000, buyer_type: 'isFTB', phase: :phase_3, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 120_000 },
    { price: 175_000, buyer_type: 'isFTB', phase: :phase_3, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 175_000 },
    { price: 201_000, buyer_type: 'isFTB', phase: :phase_3, tax_due: 520,  percentage_tax: 0.26,   precision: 0.1, total_due: 201_520 },
    { price: 250_000, buyer_type: 'isFTB', phase: :phase_3, tax_due: 1500,  percentage_tax: 0.6,   precision: 0.1, total_due: 251_500 },
    { price: 300_000, buyer_type: 'isFTB', phase: :phase_3, tax_due: 4000,  percentage_tax: 1.33,   precision: 0.1, total_due: 304_000 },
    { price: 325_000, buyer_type: 'isFTB', phase: :phase_3, tax_due: 5250,  percentage_tax: 1.62,   precision: 0.1, total_due: 330_250 },
    { price: 400_000, buyer_type: 'isFTB', phase: :phase_3, tax_due: 12750,  percentage_tax: 3.19,   precision: 0.1, total_due: 412_750 },
    { price: 743_000, buyer_type: 'isFTB', phase: :phase_3, tax_due: 47050,  percentage_tax: 6.33,   precision: 0.1, total_due: 790_050 },
    { price: 750_000, buyer_type: 'isFTB', phase: :phase_3, tax_due: 47750,  percentage_tax: 6.37,   precision: 0.1, total_due: 797_750 },
    { price: 1_200_000, buyer_type: 'isFTB', phase: :phase_3, tax_due: 101750,  percentage_tax: 8.48,   precision: 0.1, total_due: 1_301_750 },
    { price: 39_000,  buyer_type: 'isNextHome', phase: :phase_3, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 39_000 },
    { price: 40_000,  buyer_type: 'isNextHome', phase: :phase_3, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 40_000 },
    { price: 120_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 120_000 },
    { price: 260_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 2600,  percentage_tax: 1,   precision: 0.1, total_due: 262_600 },
    { price: 300_019, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 4600,  percentage_tax: 1.53,   precision: 0.1, total_due: 304_619 },
    { price: 350_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 8350,  percentage_tax: 2.39,   precision: 0.1, total_due: 358_350 },
    { price: 450_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 18350,  percentage_tax: 4.08,   precision: 0.1, total_due: 468_350 },
    { price: 550_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 28350,  percentage_tax: 5.15,   precision: 0.1, total_due: 578_350 },
    { price: 901_000, buyer_type: 'isNextHome', phase: :phase_3, tax_due: 66470,  percentage_tax: 7.38,   precision: 0.1, total_due: 967_470 }

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
