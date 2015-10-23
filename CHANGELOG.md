## 0.2.3 (October 23, 2015)

Features:
  - Can use `ChromedriverScreenshot.take_full_screenshot=` to revert to original screenshot behavior (helpful when actively writing tests)

  Performance:
    - Use `:fast_rgb` ChunkyPNG preset to more quickly encode the canvas (~99% decrease in encoding runtime)
      - Return original screenshot when stitching tiles for single-row or single-column pages (~40% decrease in encoding runtime)

## 0.1.0 (June 26, 2015)

Features:
  - Initial release
