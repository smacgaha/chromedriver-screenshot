module ChromedriverScreenshot
  class Row
    def self.from_boundaries(boundaries)
      row_ary = []
      boundaries.inject(0) do |row_top, row_bottom|
        row_ary << new(row_top, row_bottom)
        row_bottom
      end
      row_ary
    end

    def screenshot
      screenshot = Magick::ImageList.new

      @tiles.each do |tile|
        screenshot.push(tile.screenshot)
      end
      screenshot
    end

    private

    def initialize(row_top, row_bottom)
      bounds = column_boundaries
      @tiles = Tile.from_boundaries(row_top, row_bottom, column_boundaries)
    end

    def column_boundaries
      column_boundary_ary = []

      platform = ChromedriverScreenshot::Platforms.platform
      columns, partial_column_width = platform.page_width.divmod platform.window_width
      if partial_column_width > 0
        # left column will be short if page width isnt a multiple of window width
        column_boundary_ary << partial_column_width
      end

      (1..columns).each do |column|
        column_boundary_ary << partial_column_width + column*platform.window_width
      end
      column_boundary_ary
    end
  end
end
