# chromedriver-screenshot
Full page screenshots for Chrome in Selenium WebDriver

# Usage
Simply require the gem after requiring selenium-webdriver or any dependent DSL (ex. watir)
chromedriver-screenshot will snip the page into separate sections, take screenshots of each individual section, and then stitch them together to create a screenshot of the page in its entirety.

# Dependencies
chromedriver-screenshot uses [rmagick](https://github.com/rmagick/rmagick), which requires ImageMagick. The easiest way to install ImageMagick is through brew:

    brew update && brew install imagemagick

# Known issues:
0. Screenshots on Retina displays quadruple in size because Apple is a piece of shit. As a result, screenshots are cropped incorrectly.

# TODO:
0. Better inheritance/monkeypatching
0. Find a solution to the Retina bullshit
0. Refactor singleton platforms class
0. Add e2e tests
0. Finish unit tests
