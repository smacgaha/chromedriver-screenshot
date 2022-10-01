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
      offset_x, offset_y = get_offset
      screenshot = ChunkyPNG::Image.from_blob(screenshot_blob)
      scale_factor = ChromedriverScreenshot::Platforms.platform.device_pixel_ratio

      screenshot.crop(offset_x * scale_factor, offset_y * scale_factor, @width * scale_factor, @height * scale_factor)
    end

    private

    def get_screenshot
      platform = ChromedriverScreenshot::Platforms.platform
      platform.scroll_to @x, @y
      platform.screenshot
    end

    # can't scroll past ends of page, so sometimes position won't be accurate
    def get_offset
      platform = ChromedriverScreenshot::Platforms.platform
      offset_x = @x - platform.window_x
      offset_y = @y - platform.window_y
      [offset_x, offset_y]
    end
  end
end
