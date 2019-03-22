Given('I visit the land and buildings transaction tax page') do
  @stamp_duty = UI::Pages::LandAndBuildingsTransactionTax.new
  @stamp_duty.load
end

Given('I fill in details for a first time buyer') do
  step('I enter a house price of "300000"')
  step('I am a first time buyer')
end

Given('I fill in details for a next home buyer') do
  step('I enter a house price of "300000"')
  step('I am a next home buyer')
end

Given('I fill in details for a additional home buyer') do
  step('I enter a house price of "300000"')
  step('I am an additional or buy-to-let property buyer')
end

When('I enter a house price of {string}') do |price|
  @stamp_duty.property_price.set price.to_i
end

When('I progress to the results page') do
  step('I click next')
end

When('I click on the How is this Calculated information icon') do
  @stamp_duty.how_is_this_calculated_link.click
end

Then('I should see the values on the information panel as:') do |table|
  rows = table.raw
  headings = rows[0].join(' ')
  
  expect(@stamp_duty.lbtt_ftb_table_headings.first).to have_content(headings)

  (1..(rows.count - 1)).each do |index|
    expect(
      @stamp_duty.lbtt_how_calculated_examples[index-1]
    ).to have_content(rows[index].join(' '))
  end
end
