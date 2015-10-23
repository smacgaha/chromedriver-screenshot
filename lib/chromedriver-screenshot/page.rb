module ChromedriverScreenshot
  class Page
    def initialize
      bounds = row_boundaries
      @rows = Row.from_boundaries(bounds)
    end

    def full_screenshot
      rows = @rows.map { |row| row.screenshot }

      return rows.first if rows.size == 1 # don't need to process w/ Chunky

      page_height = rows.inject(0) do |height, row|
        height += row.height
      end
      page_width = rows.first.width # assume all rows have same width
      screenshot = ChunkyPNG::Image.new(page_width, page_height)

      image_row = 0
      rows.each do |row|
        row_height = row.height - 1
        (0..row.height - 1).each do |row_y|
          new_image_row = row.row(row_y)
          screenshot.replace_row!(image_row + row_y, new_image_row)
        end
        image_row += row.height
      end

      screenshot
    end

    private

    def row_boundaries
      row_boundary_ary = []

      platform = ChromedriverScreenshot::Platforms.platform

      new_boundary = platform.window_height
      while new_boundary < platform.page_height
        row_boundary_ary << new_boundary
        new_boundary += platform.window_height
      end
      row_boundary_ary << platform.page_height
    end
  end
end
