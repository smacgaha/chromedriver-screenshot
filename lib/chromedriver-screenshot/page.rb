module ChromedriverScreenshot
  class Page < Section
    def initialize
      platform = ChromedriverScreenshot::Platforms.platform
      boundaries = get_section_boundaries(platform.window_height, platform.page_height)
      @subsections = rows_from_boundaries(row_boundaries)
    end

    def full_screenshot
      Base64::encode64(super.append(true).to_blob)
    end

    private

    def rows_from_boundaries(boundaries)
      row_ary = []
      boundaries.inject(0) do |row_top, row_bottom|
        row_ary << Row.new(row_top, row_bottom)
        row_bottom
      end
      row_ary
    end
  end
end
