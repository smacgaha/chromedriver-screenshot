browser = Selenium::WebDriver.for :chrome

Before do
  @browser = browser

  # ensure that build/cucumber exists
  FileUtils.mkdir_p logs_directory
end

at_exit do
  browser.close
end
