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
      screenshot_blob = screenshot_from_platform
      offset_x, offset_y = offset_from_platform
      screenshot = ChunkyPNG::Image.from_blob(screenshot_blob)
      screenshot.crop(offset_x, offset_y, @width, @height)
    end

    private

    def screenshot_from_platform
      platform = ChromedriverScreenshot::Platforms.platform
      platform.scroll_to @x, @y
      platform.screenshot
    end

    # can't scroll past ends of page, so sometimes position won't be accurate
    def offset_from_platform
      platform = ChromedriverScreenshot::Platforms.platform
      offset_x = @x - platform.window_x
      offset_y = @y - platform.window_y
      [offset_x, offset_y]
    end
  end
end
