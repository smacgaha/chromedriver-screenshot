module StepHelpers
  def support_directory
    File.dirname(__FILE__)
  end

  def logs_directory
    File.join(support_directory, '..', '..', 'build', 'cucumber')
  end
end

World(StepHelpers)
