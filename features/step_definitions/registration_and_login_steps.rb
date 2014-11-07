def fill_signup_form(selector =  "#new_user", email = "test@test.com", password = 'qweqweqwe')
  within selector do
    fill_in "user_email",    :with => email
    fill_in "user_password", :with => password
  end
end

def fill_signin_form(user, selector)
  within selector do
    fill_in "user_email",    :with => user.email
    fill_in "user_password", :with => 'qweqweqwe'
  end
end

Given(/^I am a logged user$/) do
  @user = FactoryGirl.create(:user)
  visit dev_path("impersonate", :user_id => @user.id)
end

Given(/^I visit the frontpage$/) do
  visit "/"
end

Then(/^the dashboard gets showed$/) do
  expect(page).to have_css("body.dashboard")
end

Then(/^the login page gets showed$/) do
  expect(page).to have_css(".sessions-new")
end

Given(/^I am not registered$/) do
end

When(/^I submit wrong user credentials for signup$/) do
  fill_signup_form("#new_user", nil)
  submit_form "#new_user"
end

When(/^I submit good user credentials for signup$/) do
  fill_signup_form
  submit_form "#new_user"
  @user = User.find_by_email("test@test.com")
end


Then(/^I should be logged in as a user$/) do
  # Use this when the user name leads to a menu
  # find(".t_user_menu").click_link(@user.email)
  expect(page).to have_content("Logout")
  expect(@user).to_not be_nil
end

Given(/^I am a registered user$/) do
  @user = FactoryGirl.create(:user)
end

When(/^I submit good login credentials in the header$/) do
  # Use this if you have a "Log In" Dropmenu
  # And remember to add @javascript to the step
  # find('button', text: /Log In/i).click

  # this is in case you need to specify a new_user_session_url(protocol:'https', port:"8443") in your view
  # which conflicts with the capybara server due to his use of the ports
  # page.execute_script("$('.t_login_form').attr('action', '#{new_user_session_path}')")

  fill_signin_form(@user, ".t_login_form")
  submit_form '.t_login_form'
end

When(/^I submit wrong login credentials in the header$/) do
  # Use this if you have a "Log In" Dropmenu
  # And remember to add @javascript to the step
  # find('button', text: /Log In/i).click

  # this is in case you need to specify a new_user_session_url(protocol:'https', port:"8443") in your view
  # which conflicts with the capybara server due to his use of the ports
  # page.execute_script("$('.t_login_form').attr('action', '#{new_user_session_path}')")
  fill_signin_form(OpenStruct.new(email:"aaa@aaa.com"), ".t_login_form")
  submit_form '.t_login_form'
end

Then(/^I submit wrong login credentials for login$/) do
  fill_signin_form(OpenStruct.new(email:"aaa@aaa.com"), "#new_user")
  submit_form "#new_user"
end

Then(/^I submit good login credentials for login$/) do
  fill_signin_form(@user, "#new_user")
  submit_form "#new_user"
end

Then(/^I am not signed in$/) do
  @user = nil
  expect(page).to_not have_content("Logout")
end
