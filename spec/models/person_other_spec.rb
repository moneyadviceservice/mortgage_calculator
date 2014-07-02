# encoding: utf-8

require 'spec_helper'

describe MortgageCalculator::PersonOther do
  it 'defaults annual_income to zero' do
    expect(subject.annual_income).to be_zero
  end

  it 'defaults monthly_net_income to zero' do
    expect(subject.monthly_net_income).to be_zero
  end
end
