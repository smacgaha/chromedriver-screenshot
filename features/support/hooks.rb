browser = Selenium::WebDriver.for :chrome

desired_window_height = 600
desired_window_width = 1024
browser.manage.window.resize_to(desired_window_width, desired_window_height)

window_height = browser.execute_script ChromedriverScreenshot::Platforms::WINDOW_HEIGHT_SCRIPT
window_width = browser.execute_script ChromedriverScreenshot::Platforms::WINDOW_WIDTH_SCRIPT

browser.manage.window.resize_to(desired_window_width*2 - window_width, desired_window_height*2 - window_height)

Before do
  @browser = browser

  # ensure that build/cucumber exists
  FileUtils.mkdir_p logs_directory
end

at_exit do
  browser.close
end
