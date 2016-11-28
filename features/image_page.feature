Feature: Image Page

  Scenario: Take screenshot of single window page
    Given I am on the single window page
    When I take a screenshot
    Then the screenshot matches the stored single window image
