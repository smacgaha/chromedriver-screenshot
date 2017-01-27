module ChromedriverScreenshot
  class Platforms
    WINDOW_WIDTH_SCRIPT = "return document.documentElement.clientWidth"
    WINDOW_HEIGHT_SCRIPT = "return document.documentElement.clientHeight"
    def self.platform
      @platform
    end

    def self.create_platform(bridge)
      @platform = new(bridge)
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

    def screenshot
      @bridge.window_screenshot.unpack("m")[0]
    end

    def scroll_to(x, y)
      execute_script("window.scrollTo(#{x}, #{y})")
      sleep 1 # don't know why this is necessary
    end

    private

    def initialize(bridge)
      @bridge = bridge
    end

    def execute_script(script)
      @bridge.execute_script(script)
    end
  end
end
