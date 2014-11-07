Given(/^I visit the bootstrap data test page$/) do
  visit '/dev/bootstrap_data'
end

Then(/^I see a text that reads "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
