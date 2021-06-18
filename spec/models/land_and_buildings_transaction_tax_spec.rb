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
    { price: 120_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 4800,  percentage_tax: 4.00,   precision: 0.1, total_due: 124_800 },
    { price: 175_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 7600,  percentage_tax: 4.34,   precision: 0.1, total_due: 182_600 },
    { price: 201_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 9160,  percentage_tax: 4.56,   precision: 0.1, total_due: 210_160 },
    { price: 250_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 12100,  percentage_tax: 4.84,   precision: 0.1, total_due: 262_100 },
    { price: 300_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 16600,  percentage_tax: 5.53,   precision: 0.1, total_due: 316_600 },
    { price: 325_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 18850,  percentage_tax: 5.80,   precision: 0.1, total_due: 343_850 },
    { price: 400_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 29350,  percentage_tax: 7.34,   precision: 0.1, total_due: 429_350 },
    { price: 743_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 77370,  percentage_tax: 10.41,   precision: 0.1, total_due: 820_370 },
    { price: 750_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 78350,  percentage_tax: 10.45,   precision: 0.1, total_due: 828_350 },
    { price: 1_200_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 150350,  percentage_tax: 12.53,   precision: 0.1, total_due: 1_350_350 },

    { price: 39_000,  buyer_type: 'isFTB', phase: :phase_1, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 39_000 },
    { price: 40_000,  buyer_type: 'isFTB', phase: :phase_1, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 40_000 },
    { price: 120_000, buyer_type: 'isFTB', phase: :phase_1, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 120_000 },
    { price: 175_000, buyer_type: 'isFTB', phase: :phase_1, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 175_000 },
    { price: 201_000, buyer_type: 'isFTB', phase: :phase_1, tax_due: 520,  percentage_tax: 0.26,   precision: 0.1, total_due: 201_520 },
    { price: 250_000, buyer_type: 'isFTB', phase: :phase_1, tax_due: 1500,  percentage_tax: 0.6,   precision: 0.1, total_due: 251_500 },
    { price: 300_000, buyer_type: 'isFTB', phase: :phase_1, tax_due: 4000,  percentage_tax: 1.33,   precision: 0.1, total_due: 304_000 },
    { price: 325_000, buyer_type: 'isFTB', phase: :phase_1, tax_due: 5250,  percentage_tax: 1.62,   precision: 0.1, total_due: 330_250 },
    { price: 400_000, buyer_type: 'isFTB', phase: :phase_1, tax_due: 12750,  percentage_tax: 3.19,   precision: 0.1, total_due: 412_750 },
    { price: 743_000, buyer_type: 'isFTB', phase: :phase_1, tax_due: 47050,  percentage_tax: 6.33,   precision: 0.1, total_due: 790_050 },
    { price: 750_000, buyer_type: 'isFTB', phase: :phase_1, tax_due: 47750,  percentage_tax: 6.37,   precision: 0.1, total_due: 797_750 },
    { price: 1_200_000, buyer_type: 'isFTB', phase: :phase_1, tax_due: 101750,  percentage_tax: 8.48,   precision: 0.1, total_due: 1_301_750 },
    { price: 39_000,  buyer_type: 'isNextHome', phase: :phase_1, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 39_000 },
    { price: 40_000,  buyer_type: 'isNextHome', phase: :phase_1, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 40_000 },
    { price: 120_000, buyer_type: 'isNextHome', phase: :phase_1, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 120_000 },
    { price: 260_000, buyer_type: 'isNextHome', phase: :phase_1, tax_due: 2600,  percentage_tax: 1,   precision: 0.1, total_due: 262_600 },
    { price: 300_019, buyer_type: 'isNextHome', phase: :phase_1, tax_due: 4600,  percentage_tax: 1.53,   precision: 0.1, total_due: 304_619 },
    { price: 350_000, buyer_type: 'isNextHome', phase: :phase_1, tax_due: 8350,  percentage_tax: 2.39,   precision: 0.1, total_due: 358_350 },
    { price: 450_000, buyer_type: 'isNextHome', phase: :phase_1, tax_due: 18350,  percentage_tax: 4.08,   precision: 0.1, total_due: 468_350 },
    { price: 550_000, buyer_type: 'isNextHome', phase: :phase_1, tax_due: 28350,  percentage_tax: 5.15,   precision: 0.1, total_due: 578_350 },
    { price: 901_000, buyer_type: 'isNextHome', phase: :phase_1, tax_due: 66470,  percentage_tax: 7.38,   precision: 0.1, total_due: 967_470 },

    { price: 39_000,  buyer_type: 'isFTB', phase: :phase_2, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 39_000 },
    { price: 40_000,  buyer_type: 'isFTB', phase: :phase_2, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 40_000 },
    { price: 120_000, buyer_type: 'isFTB', phase: :phase_2, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 120_000 },
    { price: 175_000, buyer_type: 'isFTB', phase: :phase_2, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 175_000 },
    { price: 201_000, buyer_type: 'isFTB', phase: :phase_2, tax_due: 520,  percentage_tax: 0.26,   precision: 0.1, total_due: 201_520 },
    { price: 250_000, buyer_type: 'isFTB', phase: :phase_2, tax_due: 1500,  percentage_tax: 0.6,   precision: 0.1, total_due: 251_500 },
    { price: 300_000, buyer_type: 'isFTB', phase: :phase_2, tax_due: 4000,  percentage_tax: 1.33,   precision: 0.1, total_due: 304_000 },
    { price: 325_000, buyer_type: 'isFTB', phase: :phase_2, tax_due: 5250,  percentage_tax: 1.62,   precision: 0.1, total_due: 330_250 },
    { price: 400_000, buyer_type: 'isFTB', phase: :phase_2, tax_due: 12750,  percentage_tax: 3.19,   precision: 0.1, total_due: 412_750 },
    { price: 743_000, buyer_type: 'isFTB', phase: :phase_2, tax_due: 47050,  percentage_tax: 6.33,   precision: 0.1, total_due: 790_050 },
    { price: 750_000, buyer_type: 'isFTB', phase: :phase_2, tax_due: 47750,  percentage_tax: 6.27,   precision: 0.1, total_due: 797_750 },
    { price: 1_200_000, buyer_type: 'isFTB', phase: :phase_2, tax_due: 101750,  percentage_tax: 8.48,   precision: 0.1, total_due: 1_301_750 },
    { price: 39_000,  buyer_type: 'isNextHome', phase: :phase_2, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 39_000 },
    { price: 40_000,  buyer_type: 'isNextHome', phase: :phase_2, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 40_000 },
    { price: 120_000, buyer_type: 'isNextHome', phase: :phase_2, tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 120_000 },
    { price: 260_000, buyer_type: 'isNextHome', phase: :phase_2, tax_due: 2600,  percentage_tax: 1,   precision: 0.1, total_due: 262_600 },
    { price: 300_019, buyer_type: 'isNextHome', phase: :phase_2, tax_due: 4600,  percentage_tax: 1.53,   precision: 0.1, total_due: 304_619 },
    { price: 350_000, buyer_type: 'isNextHome', phase: :phase_2, tax_due: 8350,  percentage_tax: 2.39,   precision: 0.1, total_due: 358_350 },
    { price: 450_000, buyer_type: 'isNextHome', phase: :phase_2, tax_due: 18350,  percentage_tax: 4.08,   precision: 0.1, total_due: 468_350 },
    { price: 550_000, buyer_type: 'isNextHome', phase: :phase_2, tax_due: 28350,  percentage_tax: 5.15,   precision: 0.1, total_due: 578_350 },
    { price: 901_000, buyer_type: 'isNextHome', phase: :phase_2, tax_due: 66470,  percentage_tax: 7.38,   precision: 0.1, total_due: 967_470 },

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

      completion_date = case scenario[:phase]
                        when :phase_1
                          Date.new(2021, 4, 21)
                        when :phase_2
                          Date.new(2021, 7, 21)
                        when :phase_3
                          Date.new(2021, 10, 21)
                        else
                          Date.new(2022, 1, 1)
                        end

      context "When house price is #{scenario[:price]} #{context_name} and completion_date is #{completion_date}" do
        subject { described_class.new(price: scenario[:price], buyer_type: scenario[:buyer_type], completion_date: completion_date) }

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
