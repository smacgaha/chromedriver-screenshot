Given(/^I am on the (.*) window page$/) do |page_type|
  fixture_dir = case page_type
                when "single"
                  "single_window_image"
                when "multiple"
                  "multiple_window_image"
                end
  @fixture_dir = File.join(support_directory, "fixtures", fixture_dir)
  filepath = File.join(@fixture_dir, "test_page.html")
  @browser.get "file://#{filepath}"
end

When(/^I take a screenshot$/) do
  @actual_screenshot_path = File.join(logs_directory, "test_screenshot_#{timestamp}.png")
  @browser.save_screenshot @actual_screenshot_path
end

Then(/^the screenshot matches the stored image$/) do
  expected_screenshot_path = File.join(@fixture_dir, "expected_screenshot.png")
  Image.new(@actual_screenshot_path).should_match(expected_screenshot_path)
end
