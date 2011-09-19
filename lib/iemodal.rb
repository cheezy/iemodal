require "iemodal/version"

module IEModal

	def self.included(cls)
		alias_method "page_object_modal_dialog" "modal_dialog"
		define_method("modal_dialog") do |*args|
			return iemodal_watir_modal_dialog(*args) if is_ie_watir_webdriver
			return iemodal_selenium_modal_dialog(*args) if is_ie_selenium_webdriver
			return page_object_modal_dialog(*args) 			
		end
	end		
		
	def iemodal_watir_modial_dialog(&block)
		original_handles = browser.wd.window_handles
		yield if block_given?
		handles = nil
		browser.wait do
  			handles = browser.wd.window_handles
  			handles.size == original_handles.size + 1
		end
		modal = (handles - original_handles).first
		browser.wd.switch_to.window modal
	end
	
	def iemodal_selenium_modal_dialog(&block)
		original_handles = browser.window_handles
		yield if block_given?
		handles = nil
		browser.wait.until do
  			handles = browser.window_handles
  			handles.size == original_handles.size + 1
		end
		modal = (handles - original_handles).first
		browser.switch_to.window modal
	end
	
	def is_ie_watir_webdriver
		return @browser.is_a Watir::Browser and 
			@browser.wd.bridge.is_a Selenium::Webdriver::IE::Bridge
	end
	
	def is_ie_selenium_webdriver
		return @browser.is_a Selenium::WebDriver::Driver and 
			@browser.bridge.is_a Selenium::Webdriver::IE::Bridge
	end

end


