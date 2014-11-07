Given /^PENDING/ do
  pending
end

When(/^It doesn't blow up$/) do
  # nothing here
end

Then(/^I see there are errors$/) do
  expect(page).to have_css(".errors", visible:true)
end

When(/^I click on the "(.*?)" link$/) do |link_text|
  first("a", text: /#{link_text}/i).click
end

Then(/^I see a flash alert "(.*?)"$/) do |message|
  find("[data-alert='#{message}']")
end

Then(/^I see a flash notice "(.*?)"$/) do |message|
  find("[data-notice='#{message}']")
end

def submit_form(form_name)
  btn = "#{form_name} input[type='submit']"
  find(btn).click
end
