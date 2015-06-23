module ChromedriverScreenshot
  class Tile
    def initialize(top_left, bot_right)
      @x, @y = top_left
      @width = bot_right[0] - @x
      @height = bot_right[1] - @y
    end

    def screenshot
      screenshot_blob = get_screenshot
      screenshot = Magick::Image.from_blob(screenshot_blob).first
      screenshot.crop!(0, 0, @width, @height)
      screenshot
    end

    private

    def get_screenshot
      platform = ChromedriverScreenshot::Platforms.platform
      platform.scroll_to @x, @y
      platform.screenshot
    end
  end
end
