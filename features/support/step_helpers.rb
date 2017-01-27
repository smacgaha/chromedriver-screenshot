module StepHelpers
  def support_directory
    File.dirname(__FILE__)
  end

  def logs_directory
    File.join(support_directory, "..", "..", "build", "cucumber")
  end

  def timestamp
    Time.now.strftime("%s%3N")
  end
end

World(StepHelpers)
