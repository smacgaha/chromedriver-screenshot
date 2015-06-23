$:.push File.expand_path("../lib", __FILE__)
require "chromedriver-screenshot/version"

Gem::Specification.new do |s|
  s.name        = "chromedriver-screenshot"
  s.version     = ChromedriverScreenshot::VERSION
  s.authors     = "Sean MacGahan"
  s.email       = "smacgaha@gmail.com"
  s.summary     = "Full-page screenshots for Chromedriver"
  s.description = "Full-page screenshots for Chrome in Selenium WebDriver"
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "rmagick", "2.15.2"

  s.add_development_dependency "rspec", "~> 3.2"
end
