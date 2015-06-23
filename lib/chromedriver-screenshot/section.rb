module ChromedriverScreenshot
  class Section
    def screenshot
      screenshot = Magick::ImageList.new

      @subsections.each do |subsection|
        screenshot.push(subsection.screenshot)
      end

      screenshot
    end

    private

    def get_section_boundaries(window, page)
      boundary_ary = []

      n_subsections, partial_subsection = page.divmod window

      if partial_subsection > 0
        boundary_ary << partial_subsection
      end

      (1..n_subsections).each do |subsection|
        boundary_ary << partial_subsection + subsection*window
      end
      boundary_ary
    end
  end
end
