module ChromedriverScreenshot
  class Row < Section
    def screenshot
      super.append(false)
    end

    def initialize(row_top, row_bottom)
      platform = ChromedriverScreenshot::Platforms.platform
      column_boundaries = get_section_boundaries(platform.window_height, platform.page_height)
      @subsections = tiles_from_boundaries(row_top, row_bottom, column_boundaries)
    end

    private

    def tiles_from_boundaries(row_top, row_bottom, boundaries)
      tile_ary = []
      boundaries.inject(0) do |column_left, column_right|
        tile_ary << new([column_left, row_top], [column_right, row_bottom])
        column_right
      end
      tile_ary
    end
  end
end
