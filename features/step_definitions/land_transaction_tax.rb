Given('I visit the land transaction tax page') do
  @stamp_duty = UI::Pages::LandTransactionTax.new
  @stamp_duty.load
end
