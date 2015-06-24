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
      tiles = @tiles.map { |tile| tile.screenshot }

      row_width = tiles.inject(0) do |width, tile|
        width += tile.width
      end
      row_height = tiles.first.height # assume all tiles have same height
      screenshot = ChunkyPNG::Image.new(row_width, row_height)

      (1..row_height).each do |row|
        new_row = tiles.inject([]) do |concatenated_row, tile|
          concatenated_row += tile.row(row - 1)
        end
        screenshot.replace_row!(row - 1, new_row)
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

      new_boundary = platform.window_width
      while new_boundary < platform.window_width
        column_boundary_ary << new_boundary
        new_boundary += platform.window_width
      end
      column_boundary_ary << platform.page_width
    end
  end
end
