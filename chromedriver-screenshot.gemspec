$:.push File.expand_path("../lib", __FILE__)
require "chromedriver-screenshot/version"

Gem::Specification.new do |s|
  s.name        = "chromedriver-screenshot"
  s.version     = ChromedriverScreenshot::VERSION
  s.authors     = "Sean MacGahan"
  s.email       = "smacgaha@gmail.com"
  s.homepage    = "http://github.com/smacgaha/chromedriver-screenshot"
  s.summary     = "Full-page screenshots for Chromedriver"
  s.description = "Full-page screenshots for Chrome in Selenium WebDriver"
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "oily_png", "~> 1.2"
  s.add_dependency "selenium-webdriver", ">= 2.0"

  s.add_development_dependency "appraisal", "~> 2.1.0"
  s.add_development_dependency "rspec", "~> 3.2"
  s.add_development_dependency "cucumber", "~> 2.4.0"
  s.add_development_dependency "rake", "~> 10.5.0"
  s.add_development_dependency "rmagick", "~> 2.16.0"
end
