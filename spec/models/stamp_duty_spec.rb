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
    { price: 39_000, buyer_type: 'isSecondHome', tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 39_000 },
    { price: 40_000, buyer_type: 'isSecondHome', tax_due: 1200,  percentage_tax: 3,   precision: 0.1, total_due: 41_200 },
    { price: 125_000, buyer_type: 'isSecondHome', tax_due: 3750,  percentage_tax: 3,   precision: 0.1, total_due: 128_750 },
    { price: 185_000, buyer_type: 'isSecondHome', tax_due: 5550,  percentage_tax: 3.00,   precision: 0.1, total_due: 190_550 },
    { price: 275_000, buyer_type: 'isSecondHome', tax_due: 9500,  percentage_tax: 3.45,   precision: 0.1, total_due: 284_500 },
    { price: 300_019, buyer_type: 'isSecondHome', tax_due: 11501,  percentage_tax: 3.83,   precision: 0.1, total_due: 311_520 },
    { price: 310_000, buyer_type: 'isSecondHome', tax_due: 12300,  percentage_tax: 3.97,   precision: 0.1, total_due: 322_300 },
    { price: 400_012, buyer_type: 'isSecondHome', tax_due: 19500,  percentage_tax: 4.87,   precision: 0.1, total_due: 419_512 },
    { price: 490_000, buyer_type: 'isSecondHome', tax_due: 26700,  percentage_tax: 5.45,   precision: 0.1, total_due: 516_700 },
    { price: 510_000, buyer_type: 'isSecondHome', tax_due: 28300,  percentage_tax: 5.55,   precision: 0.1, total_due: 538_300 },
    { price: 937_000, buyer_type: 'isSecondHome', tax_due: 63060,  percentage_tax: 6.73,   precision: 0.1, total_due: 1_000_060 },
    { price: 988_882, buyer_type: 'isSecondHome', tax_due: 69804,  percentage_tax: 7.06,   precision: 0.1, total_due: 1_058_686 },
    { price: 2_100_000, buyer_type: 'isSecondHome', tax_due: 226250,  percentage_tax: 10.77,   precision: 0.1, total_due: 2_326_250 },
    { price: 185_000, buyer_type: 'isNextHome', tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 185_000 },
    { price: 275_000, buyer_type: 'isNextHome', tax_due: 1250,  percentage_tax: 0.45,   precision: 0.1, total_due: 276_250 },
    { price: 300_019, buyer_type: 'isNextHome', tax_due: 2500,  percentage_tax: 0.83,   precision: 0.1, total_due: 302_519 },
    { price: 310_000, buyer_type: 'isNextHome', tax_due: 3000,  percentage_tax: 0.97,   precision: 0.1, total_due: 313_000 },
    { price: 400_012, buyer_type: 'isNextHome', tax_due: 7500,  percentage_tax: 1.87,   precision: 0.1, total_due: 407_512 },
    { price: 490_000, buyer_type: 'isNextHome', tax_due: 12000,  percentage_tax: 2.45,   precision: 0.1, total_due: 502_000 },
    { price: 510_000, buyer_type: 'isNextHome', tax_due: 13000,  percentage_tax: 2.55,   precision: 0.1, total_due: 523_000 },
    { price: 937_000, buyer_type: 'isNextHome', tax_due: 34950,  percentage_tax: 3.73,   precision: 0.1, total_due: 971_950 },
    { price: 988_882, buyer_type: 'isNextHome', tax_due: 40138,  percentage_tax: 4.06,   precision: 0.1, total_due: 1_029_020 },
    { price: 2_100_000, buyer_type: 'isNextHome', tax_due: 163250,  percentage_tax: 7.77,   precision: 0.1, total_due: 2_263_250 },
    { price: 39_000, buyer_type: 'isFTB', tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 39_000 },
    { price: 40_000, buyer_type: 'isFTB', tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 40_000 },
    { price: 125_000, buyer_type: 'isFTB', tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 125_000 },
    { price: 185_000, buyer_type: 'isFTB', tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 185_000 },
    { price: 275_000, buyer_type: 'isFTB', tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 275_000 },
    { price: 300_019, buyer_type: 'isFTB', tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 300_019 },
    { price: 310_000, buyer_type: 'isFTB', tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 310_000 },
    { price: 400_012, buyer_type: 'isFTB', tax_due: 0,  percentage_tax: 0,   precision: 0.1, total_due: 400_012 },
    { price: 490_000, buyer_type: 'isFTB', tax_due: 3250,  percentage_tax: 0.66,   precision: 0.1, total_due: 493_250 },
    { price: 510_000, buyer_type: 'isFTB', tax_due: 4250,  percentage_tax: 0.83,   precision: 0.1, total_due: 514_250 },
    { price: 937_000, buyer_type: 'isFTB', tax_due: 34950,  percentage_tax: 3.73,   precision: 0.1, total_due: 971_950 },
    { price: 988_882, buyer_type: 'isFTB', tax_due: 40138,  percentage_tax: 4.06,   precision: 0.1, total_due: 1_029_020 },
    { price: 2_100_000, buyer_type: 'isFTB', tax_due: 163250,  percentage_tax: 7.77,   precision: 0.1, total_due: 2_263_250 }
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
