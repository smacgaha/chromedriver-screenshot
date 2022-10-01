module ChromedriverScreenshot
  class Platforms
    BODY_CLIENT_WIDTH = "document.body.clientWidth"
    DOCUMENT_CLIENT_WIDTH = "document.documentElement.clientWidth"
    BODY_CLIENT_HEIGHT = "document.body.clientHeight"
    DOCUMENT_CLIENT_HEIGHT = "document.documentElement.clientHeight"
    WINDOW_WIDTH_SCRIPT = "return Math.min(#{BODY_CLIENT_WIDTH}, #{DOCUMENT_CLIENT_WIDTH})"
    WINDOW_HEIGHT_SCRIPT = "return Math.min(#{BODY_CLIENT_HEIGHT}, #{DOCUMENT_CLIENT_HEIGHT})"
    def self.platform
      @platform
    end

    def self.create_platform(bridge, use_selenium_2_methods)
      @platform = new(bridge, use_selenium_2_methods)
    end

    def page_width
      @page_width ||= execute_script("return document.body.scrollWidth")
    end

    def page_height
      @page_height ||= execute_script("return document.body.scrollHeight")
    end

    def window_width
      @window_width ||= execute_script WINDOW_WIDTH_SCRIPT
    end

    def window_height
      @window_height ||= execute_script WINDOW_HEIGHT_SCRIPT
    end

    def window_x
      execute_script("return window.scrollX")
    end

    def window_y
      execute_script("return window.scrollY")
    end

    def device_pixel_ratio
      execute_script("return window.devicePixelRatio")
    end

    def screenshot
      @bridge.window_screenshot.unpack("m")[0]
    end

    def scroll_to(x, y)
      execute_script("window.scrollTo(#{x}, #{y})")
      sleep 1 # don't know why this is necessary
    end

    private

    def initialize(bridge, use_version_2)
      @bridge = bridge
      @use_version_2 = use_version_2
    end

    def execute_script(script)
      if @use_version_2
        @bridge.executeScript(script)
      else
        @bridge.execute_script(script)
      end
    end
  end
end
