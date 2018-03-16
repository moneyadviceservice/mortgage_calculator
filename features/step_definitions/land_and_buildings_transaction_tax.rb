Given('I visit the land and buildings transaction tax page') do
  @stamp_duty = UI::Pages::LandAndBuildingsTransactionTax.new
  @stamp_duty.load
end
