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
			return super &block			
		end
	end		
		
	def iemodal_watir_modal_dialog(&block)
		handle_modal_dialog(browser.wd, &block)
	end
	
	def iemodal_selenium_modal_dialog(&block)
		handle_modal_dialog(browser, &block)
	end
	
	private
	
	def handle_modal_dialog(driver, &block)
		original_handles = driver.window_handles
		yield if block_given?
		handles = wait_for_new_handle(original_handles, driver)
		modal = (handles - original_handles).first
		driver.switch_to.window modal
	end

	def wait_for_new_handle(original_handles, driver)
		handles = nil
		wait = Selenium::WebDriver::Wait.new(:timeout => 10)
		wait.until do
  			handles = driver.window_handles
  			handles.size == original_handles.size + 1
		end
		handles		
	end
	
	def is_ie_watir_webdriver
		return (is_watir and is_ie(@browser.wd.instance_variable_get "@bridge"))
	end
	
	def is_ie_selenium_webdriver
		return (is_selenium and is_ie(@browser.instance_variable_get "@bridge"))
	end
	
	def is_watir
		return @browser.is_a? Watir::Browser
	end
	
	def is_selenium
		@browser.is_a? Selenium::WebDriver::Driver
	end
	
	def is_ie(bridge)
		bridge.is_a? Selenium::WebDriver::IE::Bridge
	end

end


