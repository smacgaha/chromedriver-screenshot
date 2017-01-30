require 'chromedriver_screenshot/page'
require 'chromedriver_screenshot/row'
require 'chromedriver_screenshot/tile'
require 'chromedriver_screenshot/platforms'
require 'oily_png'
require 'selenium-webdriver'

module ChromedriverScreenshot
  class << self
    attr_writer :take_full_screenshots

    def take_full_screenshots
      @take_full_screenshots = true if @take_full_screenshots.nil?
      @take_full_screenshots
    end
  end
end

# really bad monkeypatching. fix this
module Selenium
  module WebDriver
    module Remote
      class Bridge
        current_version = Gem.loaded_specs['selenium-webdriver'].version
        @@use_selenium_2 = current_version < Gem::Version.create('3.0')

        def new_screenshot_method
          if browser == :chrome && ChromedriverScreenshot.take_full_screenshots
            ChromedriverScreenshot::Platforms.create_platform(
              self,
              @@use_selenium_2
            )

            screenshot = ChromedriverScreenshot::Page.new.full_screenshot
            # optimized for opaque images; greatly reduces runtime
            blob = screenshot.to_blob(:fast_rgb)
            Base64.encode64(blob)
          else
            window_screenshot
          end
        end

        if @@use_selenium_2
          alias window_screenshot getScreenshot
          alias getScreenshot new_screenshot_method
        else
          alias window_screenshot screenshot
          alias screenshot new_screenshot_method
        end
      end
    end
  end
end
