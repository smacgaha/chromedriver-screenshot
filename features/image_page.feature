Feature: Image Page

  Scenario: Take screenshot of single window page
    Given I am on the single window page
    When I take a screenshot
    Then the screenshot matches the stored image

  Scenario: Take screenshot of wide multiple window page
    Given I am on the multiple window page
    When I take a screenshot
    Then the screenshot matches the stored image
