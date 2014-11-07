Feature: Registration, Sign In, Sign Out

  Scenario: User signs up
    Given I am not registered
    When  I visit the frontpage
    And   I click on the "Register" link
    When  I submit good user credentials for signup
    Then  I should be logged in as a user
    And   the dashboard gets showed


  Scenario: User fails trying to sign up and then succeeds
    Given I am not registered
    When  I visit the frontpage
    And   I click on the "Register" link
    When  I submit wrong user credentials for signup
    Then  I see there are errors
    When  I submit good user credentials for signup
    Then  I should be logged in as a user


  Scenario: User logs in successfully from the frontpage
    Given I am a registered user
    And I visit the frontpage
    When I submit good login credentials in the header
    Then I should be logged in as a user
    And the dashboard gets showed


  Scenario: User fails trying to log in from the frontpage and then succeeds
    Given I am a registered user
    When I visit the frontpage
    When I submit wrong login credentials in the header
    Then the login page gets showed
    # And I see a flash alert "Invalid email or password."
    Then I submit wrong login credentials for login
    # And I see a flash alert "Invalid email or password."
    Then I submit good login credentials for login
    Then I should be logged in as a user
    And the dashboard gets showed

  Scenario: User logs out
    Given I am a logged user
    When  I click on the "Logout" link
    Then  I am not signed in
