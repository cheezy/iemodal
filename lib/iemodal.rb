require "iemodal/version"
require 'pp'

module IEModal

	def self.included(cls)
		alias_method "page_object_modal_dialog", "modal_dialog"
		define_method("modal_dialog") do |*args|
			return iemodal_watir_modal_dialog(*args) if is_ie_watir_webdriver
			return iemodal_selenium_modal_dialog(*args) if is_ie_selenium_webdriver
			return page_object_modal_dialog(*args) 			
		end
	end		
		
	def iemodal_watir_modial_dialog(&block)
		handle_modal_dialog(browser.wd, &block)
	end
	
	def iemodal_selenium_modal_dialog(&block)
		handle_modal_dialog(driver, &block)
	end
	
	private
	
	def handle_modal_dialog(driver, &block)
		original_handles = driver.window_handles
		yield if block_given?
		handles = nil
		driver.wait.until do
  			handles = driver.window_handles
  			handles.size == original_handles.size + 1
		end
		modal = (handles - original_handles).first
		pp :handles => handles, :original_handles => original_handles, :modal => modal
		driver.switch_to.window modal
	end
	
	def is_ie_watir_webdriver
		return (@browser.is_a Watir::Browser and @browser.wd.bridge.is_a Selenium::Webdriver::IE::Bridge)
	end
	
	def is_ie_selenium_webdriver
		return (@browser.is_a Selenium::WebDriver::Driver and @browser.bridge.is_a Selenium::Webdriver::IE::Bridge)
	end

end


