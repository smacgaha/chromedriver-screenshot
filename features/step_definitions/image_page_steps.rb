Given(/^I am on the single window page$/) do
  filepath = File.join(support_directory, "fixtures", "single_window_image", "test_page.html")
  @browser.get "file://#{filepath}"
end

When(/^I take a screenshot$/) do
  @actual_screenshot_path = File.join(logs_directory, "test_screenshot.png")
  @browser.save_screenshot @actual_screenshot_path
end

Then(/^the screenshot matches the stored single window image$/) do
  expected_screenshot_path = File.join(support_directory, "fixtures", "single_window_image", "expected_screenshot.png")
  Image.new(@actual_screenshot_path).should_match(expected_screenshot_path)
end
