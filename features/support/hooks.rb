Before do
  @browser = Selenium::WebDriver.for :chrome

  # ensure that build/cucumber exists
  FileUtils.mkdir_p logs_directory
end
