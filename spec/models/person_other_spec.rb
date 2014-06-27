# encoding: utf-8

require 'spec_helper'

describe MortgageCalculator::PersonOther do
  it 'defaults annual_income to zero' do
    expect(subject.annual_income).to be_zero
  end

  it 'defaults monthly_net_income to zero' do
    expect(subject.monthly_net_income).to be_zero
  end

  describe 'validations' do
    subject{ described_class.new annual_income: "1" }

    it 'uses second applicant translations' do
      subject.valid?
      expect(subject.errors.values.flatten).to include I18n.t("affordability.activemodel.errors.mortgage_calculator/person_other.base.take_home_is_zero")
    end
  end
end
