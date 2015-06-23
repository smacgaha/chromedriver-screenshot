module ChromedriverScreenshot
  class Tile
    def self.from_boundaries(row_top, row_bottom, boundaries)
      tile_ary = []
      boundaries.inject(0) do |column_left, column_right|
        tile_ary << new([column_left, row_top], [column_right, row_bottom])
        column_right
      end
      tile_ary
    end

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
