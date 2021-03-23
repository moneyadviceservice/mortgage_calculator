require 'spec_helper'

describe MortgageCalculator::StampDuty do
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

    context 'when "false" is given' do
      let(:buyer_type) { 'isFTB' }

      it 'is false' do
        expect(subject.send(:second_home?)).to be_falsy
      end
    end

    context 'when "true" is given' do
      let(:buyer_type) { 'isSecondHome' }

      it 'is true' do
        expect(subject.send(:second_home?)).to be_truthy
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
    { price: 0,       buyer_type: 'isFTB',        phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 0 },
    { price: 0,       buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 0 },
    { price: 0,       buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 0 },
    { price: 39_000,  buyer_type: 'isFTB',        phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 39_000 },
    { price: 39_000,  buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 39_000 },
    { price: 39_000,  buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 39_000 },
    { price: 40_000,  buyer_type: 'isFTB',        phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 40_000 },
    { price: 40_000,  buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 40_000 },
    { price: 40_000,  buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 1_200,  percentage_tax: 3,   precision: 0, total_due: 41_200 },
    { price: 125_000, buyer_type: 'isFTB',        phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 125_000 },
    { price: 125_000, buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 125_000 },
    { price: 125_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 3_750,  percentage_tax: 3,   precision: 0, total_due: 128_750 },
    { price: 185_000, buyer_type: 'isFTB',        phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 185_000 },
    { price: 185_000, buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0, total_due: 185_000 },
    { price: 185_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 5_550,  percentage_tax: 3,   precision: 0.01, total_due: 190_550 },
    { price: 275_000, buyer_type: 'isFTB',        phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0,    total_due: 275_000 },
    { price: 275_000, buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0,    total_due: 275_000 },
    { price: 275_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 8_250,  percentage_tax: 3,   precision: 0.01, total_due: 283_250 },
    { price: 310_000, buyer_type: 'isFTB',        phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0,    total_due: 310_000 },
    { price: 310_000, buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0,    total_due: 310_000 },
    { price: 310_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 9_300,  percentage_tax: 3,   precision: 0.01, total_due: 319_300 },
    { price: 490_000, buyer_type: 'isFTB',        phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0,    total_due: 490_000 },
    { price: 490_000, buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 0,      percentage_tax: 0,   precision: 0,    total_due: 490_000 },
    { price: 490_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 14_700, percentage_tax: 3,   precision: 0.01, total_due: 504_700 },
    { price: 510_000, buyer_type: 'isFTB',        phase: :phase_1, tax_due: 500,    percentage_tax: 0.1, precision: 0.1,  total_due: 510_500 },
    { price: 510_000, buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 500,    percentage_tax: 0.1, precision: 0.1,  total_due: 510_500 },
    { price: 510_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 15_800, percentage_tax: 3.1, precision: 0.01, total_due: 525_800 },
    { price: 937_500, buyer_type: 'isFTB',        phase: :phase_1, tax_due: 22_500, percentage_tax: 2.4, precision: 0.1,  total_due: 960_000 },
    { price: 937_500, buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 22_500, percentage_tax: 2.4, precision: 0.1,  total_due: 960_000 },
    { price: 937_500, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 50_625, percentage_tax: 5.4, precision: 0.01, total_due: 988_125 },
    { price: 2_100_000, buyer_type: 'isFTB',        phase: :phase_1, tax_due: 150_750, percentage_tax: 7.18,  precision: 0.1,  total_due: 2_250_750 },
    { price: 2_100_000, buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 150_750, percentage_tax: 7.18,  precision: 0.1,  total_due: 2_250_750 },
    { price: 2_100_000, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 213_750, percentage_tax: 10.18, precision: 0.01, total_due: 2_313_750 },
    # Test decimal rounding with below single examples
    { price: 400_012, buyer_type: 'isFTB',        phase: :phase_1, tax_due: 0,       percentage_tax: 0,    precision: 0,    total_due: 400_012 },
    { price: 300_019, buyer_type: 'isNextHome',   phase: :phase_1, tax_due: 0,       percentage_tax: 0,    precision: 0,    total_due: 300_019 },
    { price: 988_882, buyer_type: 'isSecondHome', phase: :phase_1, tax_due: 57_304,  percentage_tax: 5.80, precision: 0.01, total_due: 1_046_186 }
  ]

  describe 'calculation scenarios' do
    scenarios.each do |scenario|
      context_name = case scenario[:price]
                      when 'isFTB'
                        'and is first time buy'
                      when 'isNextHome'
                        'and is not a second home'
                      when 'isSecondHome'
                        'and is a second home'
                      end

      completion_date = case scenario[:phase]
                        when :phase_1
                          Date.today
                        when :phase_2
                          Date.today
                        when :phase_3
                          Date.today
                        else
                          Date.today
                        end

      context "When house price is #{scenario[:price]} #{context_name} and completion_date is #{completion_date}" do
        subject { described_class.new(price: scenario[:price], buyer_type: scenario[:buyer_type]) }

        its(:tax_due) { is_expected.to (scenario[:tax_due] == 0 ? be_zero : eq(scenario[:tax_due])) }

        its(:percentage_tax) { is_expected.to (
          if scenario[:percentage_tax] == 0
            be_zero
          elsif scenario[:percentage_tax] != 0 && scenario[:precision] != 0
            be_within(scenario[:precision]).of(scenario[:percentage_tax])
          else
            eq(scenario[:percentage_tax])
          end
        )
        }
        its(:total_due) { is_expected.to (scenario[:total_due] == 0 ? be_zero : eq(scenario[:total_due])) }
      end
    end
  end
end
