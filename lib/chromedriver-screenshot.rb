require 'chromedriver-screenshot/section'
require 'chromedriver-screenshot/page'
require 'chromedriver-screenshot/row'
require 'chromedriver-screenshot/tile'
require 'chromedriver-screenshot/platforms'
require "rmagick"

# really bad monkeypatching. fix this.
module Selenium
  module WebDriver
    module Chrome
      class Bridge < Remote::Bridge
        alias_method :window_screenshot, :getScreenshot
        def getScreenshot
          ChromedriverScreenshot::Platforms.create_platform(self)
          page = ChromedriverScreenshot::Page.new
          page.full_screenshot
        end
      end
    end
  end
end
