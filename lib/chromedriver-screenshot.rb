require 'chromedriver-screenshot/page'
require 'chromedriver-screenshot/row'
require 'chromedriver-screenshot/tile'
require 'chromedriver-screenshot/platforms'
require "oily_png"
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
        @@use_selenium_2 = Gem.loaded_specs["selenium-webdriver"].version < Gem::Version.create('3.0')

        def new_screenshot_method
          if browser == :chrome && ChromedriverScreenshot.take_full_screenshots
            ChromedriverScreenshot::Platforms.create_platform(self, @@use_selenium_2)

            screenshot = ChromedriverScreenshot::Page.new.full_screenshot
            blob = screenshot.to_blob(:fast_rgb) # optimized for opaque images; greatly reduces runtime
            Base64::encode64(blob)
          else
            window_screenshot
          end
        end

        if @@use_selenium_2
          alias_method :window_screenshot, :getScreenshot
          alias_method :getScreenshot, :new_screenshot_method
        else
          alias_method :window_screenshot, :screenshot
          alias_method :screenshot, :new_screenshot_method
        end
      end
    end
  end
end
