require 'rubygems'
require 'bundler'
require 'cucumber'
require 'cucumber/rake/task'

require "bundler/gem_tasks"

namespace :features do
  Cucumber::Rake::Task.new(:watir, "Run features with watir-webdriver") do |t|
    t.profile = 'watir'
  end

  Cucumber::Rake::Task.new(:selenium, "Run features with selenium-webdriver") do |t|
    t.profile = 'selenium'
  end

  desc 'Run all features'
  task :all => [:watir, :selenium]
end


