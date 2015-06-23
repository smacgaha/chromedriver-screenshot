module ChromedriverScreenshot
  class Platforms
    def self.platform
      @platform
    end

    def self.create_platform(bridge)
      @platform = new(bridge)
    end

    def page_width
      @page_width ||= @bridge.executeScript("return document.body.scrollWidth")
    end

    def page_height
      @page_height ||= @bridge.executeScript("return document.body.scrollHeight")
    end

    def window_width
      @window_width ||= @bridge.getWindowSize.width
    end

    def window_height
      @window_height ||= @bridge.getWindowSize.height
    end

    def screenshot
      @bridge.window_screenshot.unpack("m")[0]
    end

    def scroll_to(x, y)
      @bridge.executeScript("window.scrollTo(#{x}, #{y})")
      sleep 1 # don't know why this is necessary
    end

    private

    def initialize(bridge)
      @bridge = bridge
    end
  end
end
