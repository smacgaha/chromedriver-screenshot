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

      new_boundary = platform.window_height
      while new_boundary < platform.page_height
        row_boundary_ary << new_boundary
        new_boundary += platform.window_height
      end
      row_boundary_ary << platform.page_height
    end
  end
end
