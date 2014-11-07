Feature: Bootstrap Data Feature
  Bootstra data is a pattern of working that will allow to pass data from the backend to the frontend
  by serializing this data in json format in a hidden div with id:"bootstra-data".
  This data will be later on deserialized by the javascript (via a utility funcion called App.bootstrapData()
  and usually converted in to Backbone Models

  @javascript
  Scenario: The frontpage uses bootstrap data
    Given I visit the bootstrap data test page
    Then I see a text that reads "BootstrapData is working!"
