require "rspec/core/rake_task"
require "cucumber/rake/task"

desc "Run all rspec and cucumber tests"
task default: ["spec", "features"]

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:features)
