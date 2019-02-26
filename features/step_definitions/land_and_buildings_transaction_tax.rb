Given('I visit the land and buildings transaction tax page') do
  @stamp_duty = UI::Pages::LandAndBuildingsTransactionTax.new
  @stamp_duty.load
end

When('I enter a house price of {string}') do |price|
  @stamp_duty.property_price.set price.to_i
end
