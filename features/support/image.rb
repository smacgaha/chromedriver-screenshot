class Image
  def initialize(image)
    @path = image
    @image = Magick::Image.read(image)[0]
  end

  # consider turning this into a custom matcher instead
  def should_match(image_path_to_compare, max_difference: 0.10)
    image_difference = difference_from(image_path_to_compare)
    unless image_difference < max_difference
      raise(
        "Images don't match!\n"\
        "  Expected image: #{@path}\n"\
        "  Actual image: #{image_path_to_compare}\n"\
        "  Difference: #{image_difference}\n"\
        "  Threshold: #{max_difference}"
      )
    end
  end

  private

  def difference_from(image_path)
    image_to_compare = Magick::Image.read(image_path)[0]

    assert_dimensions_match(image_to_compare)

    _, diff_metric = @image.compare_channel(
      image_to_compare,
      Magick::MeanSquaredErrorMetric
    )
    diff_metric
  end

  def assert_dimensions_match(other_image)
    base_dims = [@image.columns, @image.rows]
    compared_dims = [other_image.columns, other_image.rows]
    if base_dims != compared_dims
      raise(
        "images do not match!\n"\
        "Base image: #{base_dims}\n"\
        "Compared image: #{compared_dims}"
      )
    end
  end
end
