require 'chromedriver-screenshot/page'
require 'chromedriver-screenshot/row'
require 'chromedriver-screenshot/tile'
require 'chromedriver-screenshot/platforms'
require "oily_png"
require 'selenium-webdriver'

# really bad monkeypatching. fix this
module Selenium
  module WebDriver
    module Remote
      class Bridge
        alias_method :window_screenshot, :getScreenshot
        def getScreenshot
          if browser == :chrome
            ChromedriverScreenshot::Platforms.create_platform(self)
            page = ChromedriverScreenshot::Page.new
            page.full_screenshot
          else
            window_screenshot
          end
        end
      end
    end
  end
end
