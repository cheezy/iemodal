require 'iemodal/version'
require 'page-object'
require 'watir-webdriver'
require 'selenium-webdriver'
require 'pp'

module IEModal

	def self.included(cls)
		fail("This module only works with PageObject") unless cls.instance_methods.include? :modal_dialog
		define_method("modal_dialog") do |&block|
			return iemodal_watir_modal_dialog(&block) if is_ie_watir_webdriver
			return iemodal_selenium_modal_dialog(&block) if is_ie_selenium_webdriver
			return super *args			
		end
	end		
		
	def iemodal_watir_modial_dialog(&block)
		handle_modal_dialog(browser.wd, &block)
	end
	
	def iemodal_selenium_modal_dialog(&block)
		handle_modal_dialog(browser, &block)
	end
	
	private
	
	def handle_modal_dialog(driver, &block)
		original_handles = driver.window_handles
		yield if block_given?
		handles = nil
		wait = Selenium::WebDriver::Wait.new
		wait.until do
  			handles = driver.window_handles
  			handles.size == original_handles.size + 1
		end
		modal = (handles - original_handles).first
		driver.switch_to.window modal
	end
	
	def is_ie_watir_webdriver
		return (@browser.is_a? Watir::Browser and @browser.wd.bridge.is_a? Selenium::WebDriver::IE::Bridge)
	end
	
	def is_ie_selenium_webdriver
		bridge = @browser.instance_variable_get "@bridge"
		return (@browser.is_a? Selenium::WebDriver::Driver and bridge.is_a? Selenium::WebDriver::IE::Bridge)
	end

end


