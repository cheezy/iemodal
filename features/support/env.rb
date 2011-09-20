$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'iemodal'
require 'rspec/expectations'
require 'watir-webdriver'
require 'selenium-webdriver'
require 'page-object'
require 'page-object/page_factory'

World(PageObject::PageFactory)


Before do
  @browser = Watir::Browser.new :ie if ENV['DRIVER'] == 'WATIR'
  @browser = Selenium::WebDriver.for :ie if ENV['DRIVER'] == 'SELENIUM'
end

After do
  @browser.close
end