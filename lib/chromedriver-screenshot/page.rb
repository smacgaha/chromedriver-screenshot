module ChromedriverScreenshot
  class Page
    def initialize
      bounds = row_boundaries
      @rows = Row.from_boundaries(bounds)
    end

    def full_screenshot
      screenshot = Magick::ImageList.new

      @rows.each do |row|
        screenshot.push(row.screenshot.append(false))
      end

      Base64::encode64(screenshot.append(true).to_blob)
    end

    private

    def row_boundaries
      row_boundary_ary = []

      platform = ChromedriverScreenshot::Platforms.platform
      rows, partial_row_height = platform.page_height.divmod platform.window_height
      if partial_row_height > 0
        # top row will be short if page height isnt a multiple of window height
        row_boundary_ary << partial_row_height
      end

      (1..rows).each do |row|
        row_boundary_ary << partial_row_height + row*platform.window_height
      end
      row_boundary_ary
    end
  end
end
