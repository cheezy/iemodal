Feature: handing modal dialogs

  Background:
    Given I am on the main page


  Scenario: Interacting with a modal
    When I open a modal
    Then I should be able to close the modal

